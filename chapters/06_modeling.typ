#import "@preview/supercharged-dhbw:3.4.1": *

= Modeling
Im Rahmen des CRISP-DM-Modells beschreibt die Phase des Modeling die Konzeption, Komponentenauswahl und Implementierung des KI-gestützten Agenten. Ziel dieses Kapitels ist es, die Architektur und Funktionsweise des entwickelten Systems zu erläutern sowie die zugrunde liegenden Entscheidungen und betrachteten Alternativen nachvollziehbar zu begründen. Damit leistet das Kapitel einen zentralen Beitrag zur Beantwortung der Forschungsfrage, inwieweit sich ein KI-Agent zur automatisierten Generierung von CI/CD-Pipelines für CAP-Anwendungen realisieren lässt.

== Modellverständnis und theoretische Einordnung <sec:Modellverständnis>
Um das Modell methodisch korrekt im Rahmen von CRISP-DM zu verorten, wird das in dieser Arbeit behandelte Modell gegenüber klassischen Machine-Learning- und Data-Mining-Ansätzen abgegrenzt. Dafür benötigt es zunächst eine klare Definition und Einordnung dieser Begriffe.

Klassisches Machine Learning (ML) zielt nach Zeigermann und Nguyen primär auf analytische oder prädiktive Aufgaben ab, etwa durch Supervised, Unsupervised oder Reinforcement Learning @Zeigermann2024. Data Mining bezeichnet nach Shetty et al. die Anwendung von KI-Strategien auf große Datenmengen zur Mustererkennung @Singh2022.

Das in dieser Arbeit modellierte System unterscheidet sich grundlegend von den zuvor beschriebenen Ansätzen. Sein Ziel ist generativ statt prädiktiv: Es erzeugt ein neues Code-Artefakt (eine _workflow.yml_-Datei), anstatt Werte vorherzusagen oder Muster zu klassifizieren. Der Prozess basiert auf Instruktionen über einen System-Prompt und nicht auf einem trainierten Modell mit gelabelten Daten.

Der Anwendungsbereich ist damit spezifisch - er konzentriert sich auf die Analyse und Verarbeitung einzelner CAP-Repositories - und nicht explorativ. Ein klassisches Machine-Learning-Modell wäre für diesen Anwendungsfall ungeeignet, da weder ausreichend Trainingsdaten vorliegen noch ein prädiktives Ziel existiert: Es soll kein numerischer Wert geschätzt oder ein Label vorhergesagt werden, sondern ein konkretes Artefakt generiert werden. Zudem ist der Zieloutput deterministisch - die generierte Pipeline folgt klaren technischen Regeln, die aus Projektstruktur und Metadaten abgeleitet werden können.

Ebenso sind Data-Mining-Ansätze nicht anwendbar, da diese auf die Identifikation statistischer Muster in sehr großen Datenmengen ausgerichtet sind. Im vorliegenden Kontext existieren weder große Datenmengen noch ein explorativer Erkenntnisgewinn über latente Strukturen. Stattdessen steht die regelbasierte Ableitung einer Pipeline aus wenigen, klar strukturierten Artefakten im Vordergrund.

Das entwickelte System lässt sich daher als *regelbasierter, kontextadaptiver, jedoch nicht lernfähiger KI-Agent* beschreiben. Es interpretiert die bereitgestellten Repository-Daten, leitet daraus deterministische Aktionen ab und überprüft die Ergebnisse durch eine integrierte Validierung. Damit handelt es sich nicht um ein lernendes Modell im klassischen Sinne, sondern um einen intelligenten, generativen Agenten, der auf einem LLM basiert und Aufgaben kontextbezogen ausführt.

== Systemarchitektur und Prozessmodell <sec:systemarchitektur>
Das entwickelte System lässt sich präzise als KI-gestützter Agent klassifizieren und direkt auf das im Grundlagenkapitel (siehe @sec:agent) vorgestellte Fünf-Komponenten-Modell nach Lanham abbilden. Die Gesamtarchitektur (siehe architekturabbildung) folgt einem serviceorientierten Ansatz, bei dem eine zentrale Orchestrierungsschicht (`main.py`) den sequentiellen Datenfluss steuert. Die folgenden Unterkapitel stellen die fünf Hauptkomponenten des Agenten vor und erläutern ihre Rolle in diesem sequentiellen Prozessmodell.

//#figure(
//  image("../assets/architektur-diagramm-placeholder.png"), // Platzhalter für Ihr Architekturdiagramm
//  caption: [Architektur des KI-Agenten, basierend auf einer serviceorientierten Orchestrierung.]
//) <fig:architektur>

=== User Interface Layer <sec:ui_layer>
Diese Komponente (`main.py` und Streamlit) ist für die Entgegennahme des initialen Eingabeparameters - der GitHub Repository-URL - verantwortlich. \ Durch die Bestätigung des Nutzers wird der in der Orchestrierungsschicht definierte Prozess angestoßen, der die *Planung (Planning)* des Agenten abbildet. Bei erfolgreicher Generierung präsentiert die UI die validierte Pipeline und stellt einen Button zur Initiierung des Deployments (der Pull-Request-Erstellung) bereit.

=== Repository Analyzer <sec:repository_analyzer>
Diese Komponente (analytischer Teil des `github_client.py`) agiert als "Sensor" des Agenten. Sie nimmt die Repository-URL entgegen und ist dafür verantwortlich, die "Umgebung" (das Repository) wahrzunehmen. Sie extrahiert gezielt die im *Data Understanding* (siehe @chap:data_understanding) als relevant identifizierten Dateien (z.B. _mta.yaml_, _package.json_) sowie die Anwendungsstruktur. Dabei gleicht der Analyzer die über die GitHub-API eingelesenen Dateinamen mit einer statischen Liste ab (siehe @lst:feature-extraction). \ Diese Dateien bilden das *Wissen und Gedächtnis (Knowledge/Memory)*, das als kontextbezogenes Kurzzeitgedächtnis für die Dauer der Pipeline-Generierung dient und an die nächste Komponente weitergegeben wird.

=== AI Core Integration Layer (LLM-Client) <sec:ai_core_integration>
Diese Komponente (`sap_ai_client.py`) bildet die kognitive Zentrale des Agenten. Sie nimmt die extrahierten Dateiinhalte (das Wissen) entgegen und konstruiert daraus einen detaillierten System Prompt. Dieser Prompt instruiert das über SAP AI Core angebundene LLM und definiert das *Profil (Persona)* des Agenten - seine Rolle, sein Ziel und die spezifischen Anforderungen an die zu generierende Pipeline. \ Das Ergebnis ist die vom LLM generierte CI/CD-Pipeline in Form einer _workflow.yml_-Datei, die an die nächste Komponente weitergeleitet wird.

=== Pipeline Validator <sec:pipeline_validator>
Der Validator (`validator.py`) repräsentiert die Fähigkeit des Agenten zum *Schlussfolgern und Bewerten (Reasoning/Evaluation)*. Unmittelbar nach der Generierung durch das LLM prüft diese Komponente die Pipeline als interne Qualitätssicherung. Sie führt eine deterministische YAML-Syntaxprüfung.
Diese Prüfung agiert blockierend, dass heißt, sollte die Syntaxprüfung fehlschlagen, wird der Nutzer informiert und der Prozess neu gestartet.
Es folgt eine regelbasierte Best-Practice-Analyse (z.B. Testing, CDS Model Validierung) durch und berechnet einen Qualitäts-Score. Dieser Schritt stellt sicher, dass nur syntaktisch korrekte und qualitativ ausreichende Artefakte an den Nutzer präsentiert oder weiterverarbeitet werden. Sollte die Pipeline die Kriterien nicht erfüllen, wird der Nutzer informiert und der Deployment-Prozess neugestartet.

=== Deployment Manager <sec:deployment_manager>
Der Deployment Manager (ausführende Teil des `github_client.py`) stellt den "Akteur" des Agenten dar und ist für die *Aktionen und Werkzeuge (Actions/Tool Use)* verantwortlich. Nach erfolgreicher Validierung durch den `Pipeline Validator` und auf explizite Anforderung des Nutzers über den User Interface Layer nutzt diese Komponente die GitHub-API , um in der Umgebung (dem Repository) zu handeln: Sie erstellt einen neuen Feature-Branch, committet die generierte _workflow.yml_-Datei in das _.github/workflows_-Verzeichnis und eröffnet einen Pull Request.
Dabei arbeitet der Deployment Manager mit dem GitHub-Token, welcher über contents und pull_request Rechte verfügt; Branch-Naming erfolgt timestamp-basiert. Wichitg für die Nutzung des GitHub-Tokens, dass das Profil auf Basis der Token gebaut wurde, ebenfalls über die Zugriffsrechte auf das Repository verfügt.
\
Die Pipeline ist dabei, wie im System Prompt des Agenten verankert, so konfiguriert, dass sie bereits auf die Erstellung der Pull Requests reagiert. Dies stößt unmittelbar den Build- und Test-Job an (Smart-Triggering), wodurch die generierte Pipeline sich selbst sowie die CAP-Anwendung im Kontext des Ziel-Repositories validiert. Das finale Deployment auf die Cloud Foundry Runtime erfordert somit nur noch die Freigabe und das Zusammenführen (Mergen) der Pull Request.

//#figure(
//  image("../assets/sequenzdiagramm-placeholder.png"), // Platzhalter für Ihr Sequenzdiagramm
//  caption: [Sequenzdiagramm des Pipeline-Generierungsprozesses von der Eingabe bis zum Pull Request.]
//) <fig:sequenzdiagramm>

== Modellierungsentscheidungen und Alternativen <sec:modellierungsentscheidungen>
Aufbauend auf der Systemarchitektur werden in diesem Abschnitt die zentralen Design-Entscheidungen für die gewählten Technologien und Plattformen dargelegt und begründet.

=== Auswahl des Sprachmodells <sec:modellwahl>
Es wurde sich bewusst, wie bereits in @sec:Modellverständnis angeschnitten, gegen das Trainieren und Entwickeln eines eigenen Modells entschieden. Für ein eigenständiges Modelltraining wären umfangreiche und domänenspezifisch gelabelte Daten erforderlich, die im betrachteten Kontext nicht vorliegen. Darüber hinaus wäre der hierfür notwendige technische Aufwand - insbesondere hinsichtlich Rechenressourcen, Infrastruktur und Hyperparameteroptimierung - weder wirtschaftlich noch inhaltlich gerechtfertigt. Dies gilt umso mehr, als die Arbeit primär auf einen Proof-of-Concept abzielt und damit nicht den Anspruch verfolgt, ein vollständig domänenoptimiertes Modell zu entwickeln.
\
\
\
Stattdessen fiel die Wahl auf ein vortrainiertes Large Language Model (LLM). Im Rahmen der Evaluierung verschiedener LLMs, darunter GPT-4, Claude Sonnet 2.5 sowie Gemini 2.5, zeigte sich, dass die generativen Ergebnisse hinsichtlich Strukturqualität, Konsistenz und syntaktischer Korrektheit weitgehend vergleichbar waren. Da somit kein Modell einen klaren Leistungs- oder Qualitätsvorteil aufwies, fiel die Wahl auf GPT-5 als Basismodell, da dieses auf einer aktuelleren Datengrundlage basiert und eine stabilere Kontextverarbeitung erwarten lässt.

=== Plattformwahl: SAP AI Core <sec:plattformwahl>
Für das in dieser Arbeit entwickelte System wurde SAP AI Core als Plattform zur Integration des LLM ausgewählt. Da der geplante Einsatz im SAP-Umfeld stattfindet, ist davon auszugehen, dass interne bzw. potenziell vertrauliche Daten verarbeitet werden. Die Nutzung von SAP AI Core stellt sicher, dass alle Datenflüsse innerhalb einer kontrollierten Unternehmensumgebung verbleiben und damit etablierte Datenschutz- und Compliance-Vorgaben eingehalten werden können.\
Ein zusätzlicher praktischer Vorteil ergibt sich aus der vorhandenen SAP-Lizenzierung: Die Nutzung der über AI Core angebundenen LLM-Deployments verursacht keine direkten Zusatzkosten. Dies reduziert den administrativen Aufwand und ermöglicht einen direkten Fokus auf die Umsetzung der eigentlichen Lösung. \
Grundsätzlich wären alternative Ansätze denkbar gewesen (z. B. eigenes Hosting oder die Nutzung externer Cloud-LLMs). Diese hätten allerdings zusätzliche Aufwände verursacht, etwa hinsichtlich Infrastrukturbetrieb, Sicherheitsfreigaben oder abweichender Kostenmodelle, ohne für den hier betrachteten Anwendungsrahmen erkennbare Vorteile zu bieten. \
Entsprechend erweist sich SAP AI Core als pragmatische Wahl, da es den organisatorischen Rahmenbedingungen entspricht und gleichzeitig einen sicheren und technisch eindeutigen Integrationspfad für das gewählte Sprachmodell bietet.

=== CI/CD-Plattform: GitHub Actions <sec:ci_cd_plattform>
Die für die Pipelines ausgewählte Plattform ist GitHub Actions. Diese Entscheidung basiert auf dessen nahtlosen Integration in das User Interface von GitHub. Mittels dieser können Entwickler:innen die generierten Workflows im Repository direkt einsehen und die Jobverwaltung zentral steuern. Alternative CI/CD-Plattformen wie Jenkins oder GitLab CI wurden evaluiert, jedoch zeigte sich, dass diese entweder eine komplexere Konfiguration erfordern oder nicht die gleiche Tiefe an nativer Integration in den GitHub-Workflow bieten. Ebenfalls erwies sich GitHub Actions als geeignet, da die Anbindung und Konfiguration direkt mittels der GitHub-API ermöglicht wird.

=== Programmiersprache und Technologie-Stack <sec:technologie_stack>
Als Implementierungssprache wurde Python gewählt, da die Anbindung an SAP AI Core und die GitHub-API durch ein robustes Bibliotheks-Ökosystem vereinfacht wurde.
\
Für das User Interface wurde auf die Python-Bibliothek Streamlit gesetzt. Die Wahl erfolgte aufgrund der engen Python-Integration und der Möglichkeit, interaktive Prototypen mit geringem Implementierungsaufwand zu entwickeln. Im Vergleich zu Alternativen wie Flask, Django oder React erfordert Streamlit keine separate Frontend-Logik, wodurch der Fokus auf die Kernfunktionalität des Agenten gelegt werden konnte. @Streamlit2025
\
Auch auf Implementierungsebene wurde der deterministische Ansatz fortgeführt. Es wurde sich bewusst gegen eine komplexe Mustererkennung für den `Repository Analyzer` (z.B. mittels Regex @Nagy2018) entschieden. Da die Benennung der relevanten Dateien aufgrund der CAP-Namenskonventionen klar strukturiert und vorhersehbar sind, bietet der einfache Listenabgleich mit einer statischen "Allow-List" eine höhere Effizienz und geringere Fehleranfälligkeit.

=== Prompt Engineering und Kontext-Steuerung <sec:prompt_engineering>

Eine zentrale Modellierungsentscheidung liegt im detaillierten System-Prompt (siehe Anhang), der dem LLM im `AI Core Integration Layer` übergeben wird. Dieser ist nicht als einfache Anfrage (Query) zu verstehen, sondern als primäres Instrument zur Steuerung, Einschränkung und Wissensinjektion des Agenten.

Das Prompt Engineering verfolgt dabei mehrere strategische Ziele: Es erzwingt durch strikte Anweisungen (`REQUIREMENTS`, `OUTPUT`) ein deterministisches Ausgabeformat (valides YAML), das für die maschinelle Verarbeitung durch den `Pipeline Validator` essenziell ist. Gleichzeitig erzwingt es über `PRODUCTION-GRADE FEATURES` die Einhaltung von Best Practices, wie Multi-Stage-Jobs oder "Smart Triggering", also der direkten Ausführung von Build und Test bei Erstellung der Pull-Request. Dieser statische Rahmen wird schließlich durch den dynamischen Teil (`{files_section}`) kontextualisiert, indem das im `Repository Analyzer` extrahierte Wissen (Anwendungsstruktur, _mta.yaml_ und _package.json_) zur Anpassung an die spezifische CAP-Anwendung genutzt wird.

Der System-Prompt transformiert das generische LLM somit von einem Textgenerator zu einem spezialisierten Werkzeug. Er agiert als statische Wissensbasis und regelbasierte Einschränkung, die das LLM in einen deterministischen und qualitativ hochwertigen Generator für CI/CD-Pipelines überführt.

== Grenzen und Herausforderungen <sec:grenzen_herausforderungen>
Die Grenzen des Systemes lassen sich definitv auf die fehlende Lernfähigkeit zurückführen. Da der Agent nicht in der Lage ist, aus vergangenen Generierungsprozessen zu lernen sowie Feedback vom Nutzer zu empfangen und bearbeiten, bleibt er auf die initiale Prompt- und Regelbasis beschränkt und schließt damit die Vorteile einer Feedback-Loop komplett aus. Dies limitiert die Anpassungsfähigkeit und Optimierungspotenziale des Systems im Vergleich zu lernenden Modellen erheblich. \
Direkt an diese fehlende Lernfähigkeit knüpft sich der hohe manuelle Wartungsaufwand. Da der Agent nicht in der Lage ist, sich selbstständig an neue Anforderungen oder Änderungen in den CAP-Anwendungen oder Nutzeranfordeurngen anzupassen müssen diese manuell in den System-Prompt oder die Validierungsregeln eingepflegt werden.


== Zusammenfassung der Modellierung und Übergang zur Evaluation <sec:zusammenfassung_modellierung>
Zusammenfassend wurde in dieser Phase ein *regelbasierter, kontextadaptiver KI-Agent* konzipiert und modelliert. Die Systemarchitektur (@sec:systemarchitektur) setzt die im Grundlagenkapitel definierten theoretischen Komponenten eines Agenten in einen serviceorientierten Prozess um. Die Modellierungsentscheidungen (@sec:modellierungsentscheidungen) favorisierten dabei bewusst einen deterministischen und kontrollierten Ansatz (statische Regeln, detailliertes Prompt Engineering) gegenüber einem adaptiven, lernenden Modell. \
Das Ergebnis ist ein voll funktionsfähiger Prototyp, der die im Data Understanding (@chap:data_understanding) identifizierten Merkmale von CAP-Anwendungen interpretieren und in valide CI/CD-Workflows überführen kann. \ Nachdem das Modell nun konzeptionell definiert und implementiert ist, folgt im nächsten Kapitel, die Evaluation. Diese prüft, inwieweit das Modell die im Business Understanding (@chap:business_understanding) formulierten Ziele - die Generierung korrekter und praxistauglicher Pipelines - im Rahmen der 5 CAP-Anwendungen (@chap:data_understanding) tatsächlich erfüllt.

