#import "@preview/supercharged-dhbw:3.4.1": *

= Evaluation <chap:evaluation>

Mit Abschluss des Modelings rückt im CRISP-DM-Prozess die Evaluationsphase in den Vordergrund. Während die vorherigen Schritte überwiegend technischer Natur waren, erfordert die Evaluation erneut eine enge Verzahnung zwischen technischer Perspektive und fachlichem Kontext. Ziel ist es, den entwickelten KI-Agenten nicht nur hinsichtlich seiner technischen Korrektheit zu überprüfen, sondern vor allem zu bewerten, ob er den im Business Understanding formulierten Anforderungen tatsächlich gerecht wird. Dabei wird der gesamte Entstehungsprozess - einschließlich Datenbasis, Datenqualität, Modellierungsentscheidungen und der generierten Ergebnisse - erneut reflektiert.

Im Mittelpunkt steht die Frage, inwiefern das System in der Lage ist, valide, funktionsfähige und praxistaugliche CI/CD-Pipelines für SAP-CAP-Anwendungen zu erzeugen. Da diese Pipelines produktionsnahe Artefakte darstellen, spielt neben inhaltlicher Richtigkeit insbesondere die tatsächliche Ausführbarkeit eine zentrale Rolle. Auf Grundlage dieser Bewertung wird schließlich entschieden, ob der Prototyp grundsätzlich für ein Deployment - also den Betrieb im regulären Entwicklungsumfeld - geeignet wäre.

== Evaluationsmethode: Human-as-a-Judge <sec:human_as_a_judge>

Für die Bewertung der generierten Pipelines wird ein Human-as-a-Judge-Verfahren eingesetzt. Die Ergebnisse werden dabei nicht ausschließlich anhand quantitativer Kennzahlen beurteilt, sondern vorrangig durch die fachliche Einschätzung von Personen, die im konkreten Anwendungskontext technisch kompetent und organisatorisch involviert sind. Dieser Ansatz ist insbesondere dann sinnvoll, wenn keine gelabelten Vergleichsdaten vorliegen oder die Qualität eines Artefakts nicht hinreichend über numerische Metriken erfasst werden kann @Yuan2024.

Die Bewertung wurde durch mich vorgenommen und durch erfahrene Entwickler:innen aus der Abteilung sowie weitere Kolleg:innen innerhalb der SAP fachlich flankiert. Ziel war es sicherzustellen, dass die generierten Workflows nicht nur syntaktisch valide, sondern vor allem im jeweiligen Projektkontext tatsächlich einsetzbar sind. Die Entscheidungsbasis beruht dabei auf mehreren Kriterien: Funktionsfähigkeit, syntaktische Korrektheit (insbesondere YAML-Struktur), Vollständigkeit im Hinblick auf Build-, Test- und Deployment-Schritte sowie praktische Effizienz.

Ein rein quantitatives Vorgehen - etwa über Ähnlichkeitsmaße wie S-BERT oder ROUGE - wäre nicht sinnvoll gewesen. Da für die betrachteten Repositories keine Referenz-Pipelines existierten, hätte ein Vergleich mit hypothetischen Zielformaten keine belastbare Aussagekraft. Darüber hinaus erfassen solche Metriken nicht, ob eine Pipeline tatsächlich erfolgreich lauffähig ist. Relevant ist hier vielmehr die reale Durchführbarkeit, und diese lässt sich zuverlässig nur über eine Kombination aus fachlicher Expertise, Ausführungserfahrung und projektspezifischem Kontextwissen beurteilen.

Auch LLM-as-a-Judge wurde geprüft, aber bewusst ausgeschlossen. Zwar können LLMs zur generischen Bewertung technischer Artefakte herangezogen werden @Zheng2023, allerdings ist die Qualität ihrer Einschätzungen in hochspezifischen Kontexten limitiert. Die korrekte Einschätzung von CAP-Build- und Deployment-Konfigurationen erfordert tiefes Domänenwissen und die Fähigkeit, reale Systemzustände zu berücksichtigen. Da LLMs keine Ausführungsergebnisse interpretieren können und zudem ein inhärentes Halluzinationsrisiko besteht, wären Fehlbewertungen wahrscheinlich. Darüber hinaus entsteht eine methodische Zirkularität, wenn ein Modell Ergebnisse bewertet, die von demselben (oder einem vergleichbaren) Modell erzeugt wurden – eine unabhängige Validierungsinstanz fehlt. Entsprechend war der Rückgriff auf menschliche Expertise nicht nur pragmatisch, sondern methodisch geboten.

== Durchführung

Für die Evaluation wurden fünf exemplarische CAP-Anwendungen aus unterschiedlichen Konstellationen (Variationen in Node-Versionen, Datenbanken, UI-Stack, etc.) herangezogen. Ziel war nicht, eine statistische Generalisierbarkeit zu erreichen, sondern die Leistungsfähigkeit des KI-Agenten unter realistischen und variierenden Rahmenbedingungen zu untersuchen.

Die Pipelines wurden in jeweils rund 40–50 Sekunden generiert und anschließend ausgeführt. Dabei zeigte sich, dass alle generierten Workflows nach geringfügigen Anpassungen erfolgreich lauffähig waren. Der dafür notwendige Aufwand betraf weniger die generierten Pipelines selbst als vielmehr die Repository-Struktur und deren Datenqualität, wie bereits in Data Understanding und Data Preparation beschrieben. In der Praxis waren Anpassungen an den jeweiligen CAP-Projekten häufiger erforderlich als Änderungen am Prompt oder am generierten YAML-Artefakt.

Die frühere intensive Anpassung des Prompts war vor allem in der frühen Entwicklungsphase nötig. Nach dessen Stabilisierung traten nur noch punktuelle Modifikationen auf, etwa bei Projekten mit nicht-standardisierten Strukturen. Insgesamt zeigten die generierten Pipelines ein stabiles und konsistentes Format und repräsentierten gute Entwicklungspraktiken im CAP-Umfeld.

== Bewertung

Die Ergebnisse können als positiv gewertet werden. Der Agent war dazu in der Lage, reproduzierbar funktionsfähige CI/CD-Pipelines zu erzeugen, die im Anschluss erfolgreich auf Cloud Foundry deployt werden konnten. Die generierten Workflows waren syntaktisch korrekt, praktikabel strukturiert und integrierten best-practice Komponenten wie Build- und Test-Steps sowie MTAR-Erzeugung.

Die Einbindung menschlicher Expertise erwies sich dabei als sinnvoll und notwendig: Nur durch die Kombination aus automatisierter Generierung und fachlicher Bewertung konnte sichergestellt werden, dass die Artefakte nicht nur formal korrekt erscheinen, sondern auch den realen Anforderungen des Zielsystems gerecht werden. Fachfeedback half vor allem bei der Einschätzung, ob die generierten Schritte sinnvoll priorisiert wurden und ob potenzielle Optimierungen – etwa im Hinblick auf Build-Performance oder Deployment-Zeitpunkte – denkbar wären.

== Entscheidung über Deployability

Im Sinne des CRISP-DM-Prozesses erlaubt die Evaluation eine fundierte Aussage darüber, ob sich der entwickelte Prototyp grundsätzlich für den Einsatz im realen Entwicklungsbetrieb eignet. Aufgrund der stabilen Ergebnisse, der erfolgreichen Ausführbarkeit der Pipelines und des positiven Feedbacks der beteiligten Entwickler:innen kann die grundlegende Deployability bejaht werden. Für den produktiven Einsatz wären allerdings weitere Validierungszyklen sowie eine Erweiterung des Prompts um zusätzliche Randfallregelungen empfehlenswert.