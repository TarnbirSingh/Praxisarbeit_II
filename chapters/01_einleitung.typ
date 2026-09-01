#import "@preview/supercharged-dhbw:3.4.1": *

= Einleitung
== Motivation und Problemstellung
Moderne Softwareentwicklung ist geprägt von kurzen Releasezyklen, steigenden Qualitätsanforderungen und einer zunehmenden Systemkomplexität. Um in diesem Umfeld Stabilität und Geschwindigkeit zu gewährleisten, haben sich Continuous-Integration- und Continuous-Delivery-Praktiken (CI/CD) als zentrale Bestandteile moderner Softwarebereitstellung etabliert.@Weber2015 Sie ermöglichen es, Änderungen automatisiert zu testen, zu integrieren und bereitzustellen - und damit Entwicklungsprozesse planbarer und reproduzierbarer zu gestalten.@Humble2013 @Forsgren2018  

Allerdings zeigen Studien und Praxiserfahrungen, dass die Einführung und Wartung solcher CI/CD-Prozesse mit erheblichem organisatorischem und technischem Aufwand verbunden ist. Der Aufbau von Pipelines erfordert ein tiefes Verständnis der jeweiligen Infrastruktur, der eingesetzten Frameworks und der Build-Tools. Zudem müssen diese Pipelines über ihren Lebenszyklus hinweg fortlaufend an neue Framework-Versionen, Sicherheitsrichtlinien oder geänderte Umgebungsparameter angepasst werden.@Zampetti2021 @Bajpai2024 Anders als klassische Softwaremodule sind CI/CD-Konfigurationen oft stark von betrieblichen Prozessen abhängig, was ihre Pflege besonders aufwendig und fehleranfällig macht.  

Vor diesem Hintergrund wird Automatisierung zunehmend als Schlüssel gesehen, um Entwickler:innen von repetitiven Aufgaben zu entlasten und die Effizienz in der Softwarebereitstellung zu erhöhen. Ziel ist es dabei nicht, menschliche Expertise zu ersetzen, sondern Routinetätigkeiten zu standardisieren und dadurch Kapazitäten für konzeptionelle und kreative Tätigkeiten zu schaffen.@Forsgren2018 
Aktuelle Fortschritte im Bereich generativer KI, insbesondere durch Large Language Models (LLMs), eröffnen neue Perspektiven für diese Form der Automatisierung. LLMs können auf Basis bestehender Projektstrukturen, Code-Patterns und Konfigurationsdateien eigenständig syntaktisch korrekte Artefakte erzeugen. Im Kontext von CI/CD bedeutet das die Möglichkeit, wiederkehrende Pipeline-Definitionen automatisch generieren zu lassen - mit dem Ziel, Konfigurationsaufwand zu reduzieren und gleichzeitig Konsistenz und Qualität der Deployments zu erhöhen. 

Trotz zahlreicher Automatisierungswerkzeuge bleiben viele Aspekte der Pipeline-Erstellung weiterhin manuell und kontextabhängig. Framework-spezifische Strukturen, projektspezifische Abhängigkeiten und die hohe Varianz an Deployment-Szenarien verhindern oftmals eine vollständige Standardisierung. Klassische Automatisierungslösungen - etwa Skriptvorlagen oder Template-Engines - stoßen hier an ihre Grenzen, da sie vordefinierte Muster anwenden, aber keine inhaltliche Logik aus dem Projektkontext ableiten können.@Bajpai2024

Genau an diesem Punkt setzt generative KI an: Durch Large Language Models (LLMs) wird es möglich, auf Basis von Repository-Inhalten wie Projektstruktur, Konfigurationsdateien und Abhängigkeitsdefinitionen eigenständig funktionsfähige Konfigurationsartefakte zu erzeugen. Der Einsatz eines solchen KI-gestützten Agenten eröffnet damit das Potenzial, die bisherige manuelle Arbeit bei der CI/CD-Konfiguration zu reduzieren und die Automatisierungstiefe deutlich zu erhöhen.



== Zielsetzung und Forschungsfrage
Ziel dieser Arbeit ist es daher, zu untersuchen, ob sich ein KI-gestützter Agent realisieren lässt, der für Node.js-basierte CAP-Anwendungen auf der SAP BTP automatisch funktionsfähige CI/CD-Pipelines generiert. Im Mittelpunkt steht dabei nicht nur die technische Umsetzung, sondern auch die Bewertung, ob die erzeugten Artefakte praxistauglich sind. \
Daraus leitet sich die zentrale Forschungsfrage dieser Arbeit ab:

_Inwieweit lässt sich ein KI-Agent zur automatisierten Generierung von CI/CD-Pipelines für CAP-Anwendungen realisieren?_

Zur Beantwortung dieser Frage wird ein Prototyp entwickelt, der Repository-Informationen analysiert, daraus eine Pipeline ableitet und diese als Pull Request bereitstellt. Die Praxistauglichkeit des Agenten wird anschließend in einem qualitativen Verfahren bewertet, um die Erreichung der Projektziele zu validieren.


== Aufbau der Arbeit
Die Struktur dieser Arbeit folgt dem Vorgehensmodell des CRoss-Industry Standard Process for Data Mining (CRISP-DM) @Chapman2000. Dieses Modell bildet den roten Faden, der den logischen Aufbau von der Problemdefinition bis zur fertigen Lösung vorgibt. \
Nach der Fundierung der technischen Grundlagen (@chap:grundlagen) wird in @chap:business_understanding (Business Understanding) das fachliche Problem spezifisch analysiert und die genauen Projektziele sowie die Erfolgskriterien definiert.
Darauf aufbauend folgt der datengetriebene Prozess: @chap:data_understanding (Data Understanding) analysiert die Datenbasis während @chap:data_preparation (Data Preparation) die Bereinigung und Aufbereitung dieser Daten für die maschinelle Verarbeitung beschreibt.
Den Kern der Arbeit bildet @chap:modeling (Modeling). Dieses Kapitel erläutert detailliert die Konzeption, die Systemarchitektur und die Implementierung des KI-Agenten, einschließlich des Prompt Engineerings und der Anbindung an den SAP AI Core.
Abschließend wird der entwickelte Prototyp einer kritischen Prüfung unterzogen: @chap:evaluation (Evaluation) bewertet die Ergebnisse anhand der definierten Erfolgskriterien. @chap:deployment (Deployment) beschreibt die Operationalisierung der Anwendung auf der Cloud Foundry Plattform.
Die Arbeit schließt mit Kapitel 9 (Fazit und Ausblick), das die Ergebnisse im Kontext der Forschungsfrage zusammenfasst und zukünftige Entwicklungspotenziale aufzeigt.