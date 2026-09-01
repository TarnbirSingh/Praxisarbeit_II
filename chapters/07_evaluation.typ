#import "@preview/supercharged-dhbw:3.4.1": *

= Evaluation <chap:evaluation>

Mit Abschluss des Modelings rückt im CRISP-DM-Prozess die Evaluationsphase in den Vordergrund. Während die vorherigen Schritte überwiegend technischer Natur waren, erfordert die Evaluation erneut eine enge Verzahnung zwischen technischer Perspektive und fachlichem Kontext. Ziel ist es, den entwickelten KI-Agenten nicht nur hinsichtlich seiner technischen Korrektheit zu überprüfen, sondern vor allem zu bewerten, ob er den im Business Understanding formulierten Anforderungen tatsächlich gerecht wird. Dabei wird der gesamte Entstehungsprozess - einschließlich Datenbasis, Datenqualität, Modellierungsentscheidungen und der generierten Ergebnisse - erneut reflektiert.

Im Mittelpunkt steht die Frage, inwiefern das System in der Lage ist, valide, funktionsfähige und praxistaugliche CI/CD-Pipelines für SAP-CAP-Anwendungen zu erzeugen. Da diese Pipelines produktionsnahe Artefakte darstellen, spielt neben inhaltlicher Richtigkeit insbesondere die tatsächliche Ausführbarkeit eine zentrale Rolle. Auf Grundlage dieser Bewertung wird schließlich entschieden, ob der Prototyp grundsätzlich für ein Deployment - also den Betrieb im regulären Entwicklungsumfeld - geeignet wäre.

== Evaluationsmethode: Human-as-a-Judge <sec:human_as_a_judge>

Für die Bewertung der generierten Pipelines wird ein Human-as-a-Judge-Verfahren eingesetzt. Die Ergebnisse werden dabei nicht ausschließlich anhand quantitativer Kennzahlen beurteilt, sondern vorrangig durch die fachliche Einschätzung von Personen, die im konkreten Anwendungskontext technisch kompetent und organisatorisch involviert sind. Dieser Ansatz ist insbesondere dann sinnvoll, wenn keine gelabelten Vergleichsdaten vorliegen oder die Qualität eines Artefakts nicht hinreichend über numerische Metriken erfasst werden kann.@Zheng2023a

Die Bewertung wurde durch mich vorgenommen und durch erfahrene Entwickler:innen aus der Abteilung sowie weitere Kolleg:innen innerhalb der SAP fachlich unterstützt. \ Ziel war es sicherzustellen, dass die generierten Workflows nicht nur syntaktisch valide, sondern vor allem im jeweiligen Projektkontext tatsächlich einsetzbar sind. \ \ \ Die Entscheidungsbasis beruht dabei auf den im Business Understanding definierten Kriterien:

- Funktionale Vollständigkeit:   
  Alle wesentlichen Schritte - insbesondere Build-, Test- und Deployment-Prozesse - müssen enthalten sein.

- Syntaktische Korrektheit: 
  Die Pipeline muss formal gültig sein, insbesondere im Hinblick auf die YAML-Struktur.

- Praktische Effizienz: 
  Die Pipeline sollte ohne unnötige Build- oder Deployment-Schritte auskommen und einen schlanken, nachvollziehbaren Ablauf sicherstellen.


Ein rein quantitatives Vorgehen - beispielsweise über Ähnlichkeitsmaße wie S-BERT oder ROUGE - wäre in diesem Kontext nicht zielführend. Da für die betrachteten Repositories keine Referenz-Pipelines existierten, hätte ein Vergleich mit hypothetischen Zielformaten keine belastbare Aussagekraft. Zudem erfassen solche Metriken nicht, ob eine Pipeline tatsächlich fehlerfrei ausgeführt werden kann, was in der Praxis ein gesonderter Validierungsschritt ist. @Zheng2023a
Entscheidend ist daher die reale Durchführbarkeit, die sich zuverlässig nur durch die Kombination aus fachlicher Expertise, Ausführungserfahrung und projektspezifischem Kontextwissen beurteilen lässt.

Auch LLM-as-a-Judge wurde geprüft, aber bewusst ausgeschlossen. LLMs können zwar zur theoretischen Bewertung von Code herangezogen werden, sie können jedoch nicht beurteilen, ob eine Konfiguration in der Praxis funktioniert. Um die Qualität einer CAP-Build- und Deployment-Pipeline einzuschätzen, ist Fachwissen über die SAP-spezifischen Werkzeuge und Prozesse nötig. Ein LLM kann nicht prüfen, ob die Pipeline in der realen Zielumgebung - in unserem Falle die Cloud Foundry Runtime - tatsächlich lauffähig wäre. Da LLMs keine Ausführungsergebnisse interpretieren können und zudem ein inhärentes Halluzinationsrisiko besteht, wären Fehlbewertungen wahrscheinlich @Tunstall2022. Darüber hinaus entsteht eine methodische Zirkularität, wenn ein Modell Ergebnisse bewertet, die von demselben (oder einem vergleichbaren) Modell erzeugt wurden - eine unabhängige Validierungsinstanz fehlt. Entsprechend war der Rückgriff auf #box[menschliche Expertise nicht nur pragmatisch, sondern methodisch geboten].@Gao2024 @Schroeder2024

== Durchführung

Wie im Data Understanding beschrieben, wurden für die Evaluation fünf exemplarische CAP-Anwendungen aus unterschiedlichen Konstellationen (Variationen in Node-Versionen, Datenbanken, UI-Stack, etc.) herangezogen. Ziel war nicht, eine statistische Generalisierbarkeit zu erreichen, sondern die Leistungsfähigkeit des KI-Agenten unter realistischen und variierenden Rahmenbedingungen zu untersuchen.

Die Pipelines wurden in jeweils rund 40-50 Sekunden generiert und anschließend ausgeführt. Dabei zeigte sich, dass alle generierten Workflows erfolgreich lauffähig waren; die notwendigen Anpassungen betrafen dabei fast ausschließlich die Repository-Struktur und deren Datenqualität, wie bereits in Data Understanding und Data Preparation beschrieben, und nicht die generierten Pipeline-Artefakte selbst.

Die frühere intensive Anpassung des Prompts war vor allem in der frühen Entwicklungsphase nötig. Nach dessen Stabilisierung traten nur noch punktuelle Modifikationen auf, etwa bei Projekten mit nicht-standardisierten Strukturen. Insgesamt zeigten die generierten Pipelines ein stabiles und konsistentes Format und repräsentierten #box[gute Entwicklungspraktiken im CAP-Umfeld].

== Bewertung

Die Ergebnisse können für alle fünf Testfälle als positiv gewertet werden. Der Agent war dazu in der Lage, reproduzierbar funktionsfähige CI/CD-Pipelines zu erzeugen, die im Anschluss erfolgreich die CAP-Anwendungen auf Cloud Foundry deployen konnten. Die generierten Workflows waren syntaktisch korrekt (Validiert durch den Pipeline Validator), praktikabel strukturiert und integrierten best-practice Komponenten wie Build- und Test-Steps sowie MTAR-Erzeugung.

Dieser Erfolg ist das Ergebnis eines iterativen Prozesses. Da LLMs nicht-deterministisch arbeiten, wurden die Generierungen pro Repository mehrfach ausgeführt. In frühen Testläufen traten dabei kleinere Mängel auf, beispielsweise das Einspielen der falschen Node.js-Version. Durch iteratives Prompt Engineering (Fine-Tuning am System-Prompt) konnten diese Abweichungen jedoch eliminiert werden. Die finalen Pipelines in der Evaluation wurden daraufhin bei der ersten Generierung korrekt und mit durchgehend positiver Performance in allen drei Bewertungskriterien erzeugt.

Die Einbindung menschlicher Expertise erwies sich dabei als sinnvoll und notwendig: Nur durch die Kombination aus automatisierter Generierung und fachlicher Bewertung konnte sichergestellt werden, dass die Artefakte nicht nur formal korrekt erscheinen, sondern auch den realen Anforderungen des Zielsystems gerecht werden. Fachfeedback half vor allem bei der Einschätzung, ob die generierten Schritte sinnvoll priorisiert wurden und ob potenzielle Optimierungen - etwa im Hinblick auf Build-Performance oder Deployment-Zeitpunkte - denkbar wären.

Einschränkend muss festgehalten werden, dass die Evaluation auf einer bewusst klein gehaltenen, exemplarischen Datenbasis von fünf Anwendungen beruht. Die positiven Ergebnisse sind daher nicht als statistisch repräsentative Studie zu werten, sondern als ein Nachweis der grundsätzlichen Machbarkeit und der Validierung des Lösungsansatzes (Proof-of-Concept) im Rahmen der zur Verfügung stehenden Projektdaten.

== Entscheidung über Deployability

Im Sinne des CRISP-DM-Prozesses erlaubt die Evaluation eine fundierte Aussage darüber, ob sich der entwickelte Prototyp grundsätzlich für den Einsatz im realen Entwicklungsbetrieb eignet. Aufgrund der stabilen Ergebnisse, der erfolgreichen Ausführbarkeit der Pipelines und des positiven Feedbacks der beteiligten Entwickler:innen kann die grundlegende Deployability bejaht werden. Für den produktiven Einsatz wären allerdings weitere Validierungszyklen empfehlenswert, insbesondere mit einer größeren und diversifizierteren Datenbasis (d.h. mehr CAP-Anwendungen), sowie eine Erweiterung des Prompts um zusätzliche Randfallregelungen.