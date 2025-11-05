#import "@preview/supercharged-dhbw:3.4.1": *

= Grundlagen
== Continuous Integration und Continuous Delivery/Deployment (CI/CD)
=== Continuous Integration (CI)
*Continuous Integration (CI)* ist eine zentrale Entwicklungspraxis in der Softwareentwicklung, bei der Entwickler ihre Code-Änderungen in kleinen, überschaubaren Inkrementen und in hoher Frequenz - oft mehrmals täglich - in ein zentrales, gemeinsames Repository überführen. Unmittelbar nach jeder dieser Integrationen wird ein vollautomatisierter Prozess, die sogenannte CI-Pipeline, angestoßen. Diese Pipeline kompiliert den gesamten Quellcode (erstellt einen "Build") und führt eine umfassende Squenz von automatisierten Tests aus.@Clark2025

DDas primäre Ziel dieses Vorgehens ist die frühzeitige Identifikation von Integrationsfehlern - also von Problemen, die entstehen, wenn die Code-Teile verschiedener Entwickler:innen zusammengeführt werden. Ohne kontinuierliche Integration würden solche Konflikte typischerweise erst in späten Entwicklungsphasen auffallen, was zu aufwendigen Debugging-Prozessen, längeren Release-Zyklen und einem erhöhten Risiko von Systeminstabilitäten führen kann. Durch das häufige Zusammenführen wird stattdessen eine schnelle Feedback-Schleife etabliert, die es Entwickler:innen ermöglicht, die Auswirkungen ihrer Änderungen auf das Gesamtsystem zeitnah zu verstehen und Anpassungen vorzunehmen, bevor größere Probleme entstehen. Dies trägt maßgeblich zu einer stabileren und wartungsfreundlicheren Codebasis bei.@Clark2025


Die praktische Umsetzung erfolgt durch Werkzeuge wie Jenkins oder GitHub Actions, welche die Prozessautomatisierung steuern. Eine robuste CI-Pipeline stützt sich dabei auf verschiedene Testebenen, um eine durchgehende Qualitätssicherung zu gewährleisten. Diese umfassen Unit-Tests, welche die kleinsten, isolierten Komponenten der Software auf ihre korrekte Funktionsweise prüfen, Integrationstests, welche das reibungslose Zusammenspiel verschiedener Module verifizieren, und End-to-End-Tests, welche die gesamte Anwendung durch die Simulation vollständiger Benutzerszenarien aus der Perspektive des Endnutzers testen.@Bajpai2024

\
=== Continuous Delivery (CD)

*Continuous Delivery (CD)* bezeichnet eine Entwicklungsdisziplin, bei der Software so konzipiert, gebaut und getestet wird, dass sie jederzeit produktiv auslieferbar ist. Nach Humbl liegt der Fokus darauf, die Software in einem kontinuierlich deployfähigen Zustand zu halten und sicherzustellen, dass jede Version der Anwendung auf Knopfdruck in eine beliebige Umgebung ausgerollt werden kann.@Humble2013

Continuous Delivery baut auf Continuous Integration auf, erweitert diese jedoch um die finalen Stufen, die für eine produktionsreife Bereitstellung erforderlich sind. Dazu gehört, dass jedes Build-Artefakt automatisiert getestet und in produktionsähnliche Umgebungen übertragen wird, um die Funktionsfähigkeit sicherzustellen. Grundlage bildet dabei eine sogenannte Deployment Pipeline, welche die einzelnen Phasen von Build, Test und Release automatisiert abbildet.@Humble2013

Das Ziel von Continuous Delivery ist es, das Risiko von Deployments zu reduzieren, die Nachvollziehbarkeit des Entwicklungsfortschritts zu erhöhen und schnelleres, verlässliches Feedback von Nutzern zu ermöglichen. Der wesentliche Unterschied zur Continuous Deployment besteht darin, dass Deployments bei Continuous Delivery zwar jederzeit möglich, aber nicht zwingend automatisiert erfolgen müssen. Die Entscheidung über den produktiven Rollout liegt letztlich beim Team oder dem jeweiligen Fachbereich.@Clark2025

=== Continuous Deployment (CD)

*Continuous Deployment* beschreibt den Prozess, bei dem Code-Änderungen nach erfolgreicher Validierung in der Continuous Integration-Pipeline automatisch bis in die Produktionsumgebung ausgerollt werden. Damit schließt Continuous Deployment unmittelbar an Continuous Delivery an und führt dessen Prinzipien zu Ende.@Atlassian2024

Der gesamte Übergang vom Code-Commit bis zum produktiven Release erfolgt hierbei ohne manuelle Eingriffe, wodurch menschliche Fehler reduziert und der Bereitstellungsprozess beschleunigt werden. Ziel ist es, Änderungen schnell, sicher und mit minimalem Overhead in den produktiven Betrieb zu überführen.@Atlassian2024  

Automatisierte Deployment-Pipelines bilden den Kern dieses Prozesses. Sie verifizieren, dass jede Version der Anwendung jederzeit in einem auslieferbaren Zustand ist. Dadurch wird eine kurze Time-to-Market ermöglicht, da neue Funktionen unmittelbar nach der Integration bereitgestellt werden können. Continuous Deployment ist somit die konsequenteste Form der Automatisierung im CI/CD-Kontext: Jede Änderung, die die Qualitätskriterien erfüllt, wird produktiv gestellt.@Clark2025

Im Gegensatz dazu belässt Continuous Delivery die Entscheidung über den Rollout beim Menschen. Continuous Deployment überträgt diese Entscheidung vollständig an die Pipeline selbst und realisiert damit einen durchgängigen, automatisierten Auslieferungsprozess.@Clark2025


== Cloud Application Programming Model (CAP)


== Cloud Foundry
Cloud Foundry ist eine Cloud-Native Plattform, die Anwendungen abstrahiert von der zugrundeliegenden Infrastruktur betreibt und dabei viele betriebliche Aufgaben automatisiert übernimmt. Ziel ist es, Entwickler:innen zu entlasten und die Bereitstellung von Software zu beschleunigen (Kap. 1).@Winn2017

Eine Cloud-Native Plattform integriert Funktionen wie Resilienz, Benutzerverwaltung und Logging und reduziert damit den Konfigurationsaufwand. Cloud Foundry wird dabei als structured, opinionated und open beschrieben: Sie bietet eingebaute, konsistente Funktionen (structured), folgt bewährten Prinzipien und reduziert Komplexität (opinionated), und ist offen für verschiedene Infrastrukturen, Programmiersprachen sowie Frameworks (open) (Kap. 1).@Winn2017

#figure(
  image("../assets/cloud_foundry.png", width: 90%),
  caption: [
    Entwicklung von traditionellen Infrastrukturen über IaaS und unstrukturierte Plattformen 
    hin zu Cloud Foundry als strukturierte Cloud-Native Plattform 
    @Winn2017.
  ]
)
#label("fig:cloud_foundry")

Die @fig:cloud_foundry verdeutlicht die Unterschiede zwischen traditionellen Ansätzen, IaaS, unstrukturierten Plattformen und Cloud Foundry. Während in klassischen Modellen zahlreiche Schichten manuell verwaltet werden müssen, integriert Cloud Foundry zentrale Funktionen und hebt so die Abstraktionsebene deutlich an.

Ein zentrales Konzept ist die Entlastung von undifferentiated heavy lifting tasks, also grundlegenden, aber nicht differenzierenden Infrastrukturarbeiten wie Skalierung oder Logging. Cloud Foundry übernimmt diese Aufgaben automatisch und ermöglicht es, dass sich Entwickler:innen auf die eigentliche Geschäftslogik konzentrieren können. Die Plattform agiert damit wie ein Cloud-Betriebssystem, das Anwendungen konsistent und resilient betreibt (Kap. 2).@Winn2017 

== KI-Agenten <sec:agent>
Die Entwicklung von KI-gestützten Systemen hat sich über das reine Prompt Engineering hinaus entwickelt, da komplexe Aufgaben Planung und Validierung erfordern @Lanham. In diesem Kontext hat sich das Konzept des KI-Agenten als zentraler Baustein etabliert.\
Im Kontext moderner Large Language Models (LLMs) wird der Begriff "Agent" breiter gefasst als in der klassischen KI (z.B. Reinforcement Learning). Ein Agent ist hierbei ein System, das seine Umgebung wahrnimmt, Entscheidungen trifft und über Aktoren auf diese Umgebung einwirkt, wobei das LLM als "leitende Intelligenz" zur Erreichung eines Ziels dient.@Lanham \
Nach (Lanham) werden Agenten primär durch ihren Autonomiegrad klassifiziert. Die Skala reicht von Agenten-Proxys, die lediglich Nutzereingaben optimieren, über Assistenten, die für Aktionen eine explizite Nutzerfreigabe benötigen, bis hin zu autonomen Agenten, welche eine Anfrageinterpretieren, daraufhin selbstständig einen Plan und  die notwendigen Schritte zur Zielerreichung ohne weitere Freigaben ausführen.@Lanham \
Die Systemarchitektur solcher Agenten lässt sich nach (Lanham) in fünf Kernkomponenten gliedern, die auch die theoretische Basis für das in dieser Arbeit entwickelte Modell bilden:
Das Fünf-Komponenten-Modell nach Lanham umfasst die folgenden zentralen Elemente:

#list(
  [*Profil (Persona):* Definiert als System Prompt die Rolle und das Ziel des Agenten.],
  [*Aktionen und Werkzeuge (Actions/Tool Use):* Umfassen die Fähigkeiten zur Interaktion mit der Umgebung, etwa API-Aufrufe oder den Zugriff auf externe Systeme.],
  [*Wissen und Gedächtnis (Knowledge/Memory):* Stellt den für die Aufgabenerfüllung erforderlichen Kontext bereit, beispielsweise in Form von Umgebungs- oder Projektdaten.],
  [*Schlussfolgern und Bewerten (Reasoning/Evaluation):* Beschreibt die interne Logik zur Problemlösung und Qualitätsprüfung der generierten Ergebnisse.],
  [*Planung (Planning):* Definiert den übergeordneten Workflow und steuert die Ausführung zur Erreichung des Ziels. @Lanham]
)

== Large Language Models (LLM)
Ein *Large Language Model (LLM)* ist ein auf künstlicher Intelligenz basierendes Modell, das in der Lage ist, große Mengen an Textdaten zu analysieren und darauf aufbauend Texte in natürlicher Sprache zu generieren @Cloudfare2024. Diese Modelle nutzen Deep-Learning-Methoden, insbesondere den sogenannten Transformer-Ansatz, um Sprache zu verstehen, zu verarbeiten und neue Inhalte zu erzeugen. @IBM2023

Der Transformer-Ansatz stellt eine spezialisierte Architektur des maschinellen Lernens dar, die auf dem Prinzip der Selbstaufmerksamkeit (Self-Attention) basiert. Diese ermöglicht es dem Modell, Beziehungen zwischen Wörtern, Sätzen und Kontexten zu erkennen und semantische Abhängigkeiten über lange Textabschnitte hinweg abzubilden.@Bhowmik2021\           
Dadurch kann ein LLM sprachliche Muster effizient erfassen und kontextsensitiv verarbeiten.

Technisch basieren LLMs auf tiefen neuronalen Netzen, die - inspiriert vom Aufbau und der Funktionsweise des menschlichen Gehirns - Informationen in mehreren Schichten von künstlichen Neuronen verarbeiten. Diese hierarchische Struktur erlaubt es, Bedeutungen und Zusammenhänge in Sprache abzuleiten und zu generalisieren. @Goodfellow2018

Insgesamt ermöglichen LLMs das Verständnis, die Interpretation und die Generierung von Texten, die in Stil, Struktur und Inhalt stark an menschliche Sprache angelehnt sind. Damit stellen sie die Grundlage vieler moderner generativer KI-Systeme dar, wie Chatbots, Textgeneratoren oder KI-gestützte Assistenzsysteme. @Cloudfare2024


== CRISP-DM Methodik
Die in dieser Arbeit angewandte Methodik zur Entwicklung des KI-gestützten Agents basiert auf dem CRISP-DM (*CR***oss-*I***ndustry *S***tandard *P***rocess for *D***ata *M***ining) Prozessmodell. CRISP-DM wurde 1999 veröffentlicht, um einen branchenübergreifenden Standard für Data-Mining-Projekte zu etablieren, und gilt heute als eine der am weitesten verbreiteten Vorgehensweisen in diesem Bereich. Das Modell strukturiert den Prozess in sechs Phasen, die zwar sequenziell dargestellt werden, in der Praxis jedoch häufig iterativ durchlaufen werden, was Rücksprünge zu früheren Phasen einschließt.@Chapman2000 

#figure(
image("../assets/crispdm_reference.png"),
caption: [
Die sechs Phasen des CRISP-DM Prozessmodells und ihre iterativen Beziehungen @Chapman2000.
]
)
#label("fig:crisp_dm_prozess")

Den Ausgangspunkt des Prozesses bildet das *Geschäftsverständnis (Business Understanding)*, in dem die fachlichen Projektziele und Anforderungen definiert und in eine konkrete Problemstellung sowie einen vorläufigen Plan überführt werden. Auf dieser Grundlage folgt das *Datenverständnis (Data Understanding)*, welches die initiale Erfassung und Analyse der Daten zum Ziel hat; hierbei werden deren Eigenschaften, Qualität und Relevanz für das Projektziel bewertet. In der anschließenden *Datenvorbereitung (Data Preparation)* werden die Rohdaten durch Verfahren wie die Datenkonsolidierung, Bereinigung (Data Cleansing) und Formatierung (Feature Engineering) in eine für die Modellierung geeignete Form gebracht. Die Phase der *Modellierung (Modeling)* umfasst daraufhin die Auswahl und Anwendung verschiedener Techniken zur Erstellung der Modelle, wobei deren Parameter iterativ zur Leistungssteigerung optimiert werden. Im Rahmen der *Evaluation* werden diese Modelle einer kritischen Prüfung unterzogen, um ihre Qualität und ihren Beitrag zur Erreichung der Geschäftsziele zu validieren. Den Abschluss des Zyklus bildet das *Deployment*, bei dem das erfolgreich validierte Modell in die operative Umgebung integriert wird, um die daraus resultierenden Erkenntnisse den Endanwendern bereitzustellen.@Chapman2000

#figure(
image("../assets/crispdm_task.png"),
caption: [
Hierarchische Gliederung des CRISP-DM-Modells in vier Abstraktionsebenen @Chapman2000.
]
)
#label("fig:crisp_dm_hierarchie")

Der hierarchische Aufbau des CRISP-DM-Prozesses ist der Schlüssel zu seiner Flexibilität in der Praxis. Das Modell gliedert ein Projekt in mehrere Ebenen - von der übergeordneten Strategie bis hin zu konkreten, operativen Aufgaben (siehe @fig:crisp_dm_hierarchie). Diese Struktur erlaubt es, das Vorgehen passgenau an die spezifischen Anforderungen und die Komplexität jedes einzelnen Vorhabens anzupassen: @Chapman2000

- *Allgemeine Aufgaben (Generic Tasks):* Diese beschreiben die grundlegenden Aktionen innerhalb jeder Phase. In dieser Arbeit wären das beispielsweise die "Analyse der Projektstruktur" oder die "Generierung von Pipeline-Konfigurationen".

- *Spezialisierte Aufgaben (Specialized Tasks):* Hier werden die allgemeinen Aufgaben an die konkreten Gegebenheiten des Projekts angepasst. Aus der Analyse der Projektstruktur wird beispielsweise die spezifische Aufgabe "Parsen der package.json-Datei zur Identifikation von Node.js-Abhängigkeiten". Aus der Generierung von Konfigurationen wird die Aufgabe "Erstellung einer mta.yml-Datei für das Deployment auf Cloud Foundry".

- *Prozessinstanzen (Process Instances):* Diese Ebene dokumentiert die tatsächliche Durchführung des Projekts. Sie erfasst spezifische Entscheidungen, gewählte Parameter und erzielte Ergebnisse und bildet somit ein detailliertes Protokoll des Projektverlaufs.@Chapman2000



