#import "@preview/supercharged-dhbw:3.4.1": *
#import "lib/acronyms.typ": acronyms
#import "lib/glossary.typ": glossary
#show: supercharged-dhbw.with(
  title: "Konzeption und Entwicklung eines KI-gestützten Agents zur automatisierten Generierung von CI/CD-Pipelines für CAP-Anwendungen auf Basis von Node.js",
  authors: (
    (
      name: "Tarnbir Singh",
      student-id: "9997532",
      course: "WWI23SEB",
      course-of-studies: "Wirtschaftsinformatik",
      company: (
        name: "SAP SE",
        post-code: "69190",
        city: "Walldorf",
        street: "Dietmar-Hopp-Allee 16"
      ),
    ),
  ),
  type-of-thesis: "Praxisarbeit",
  acronyms: acronyms, // displays the acronyms defined in the acronyms dictionary
  at-university: false, // if true the company name on the title page and the confidentiality statement are hidden
  bibliography: bibliography("sources.bib"),
  date: datetime.today(),
  glossary: none, // displays the glossary terms defined in the glossary dictionary
  language: "de", // en, de
  supervisor: (
    university: "Prof. Dr. Sarah Detzler",
    company: "Niklas Miroll"
    ),
  university: "Duale Hochschule Baden-Württemberg",
  university-location: "Mannheim",
  university-short: "DHBW",
  logo-left: image("assets/sap.png"),
  logo-right: image("assets/dhbw.png"),
  bib-style: "ieee",
  page-numbering: (preface: "I", main: "1", appendix: "I"),
  numbering-alignment: right,
  show-list-of-figures: true,
  show-list-of-tables: true,
  show-code-snippets: true,
  show-confidentiality-statement: false,
  show-declaration-of-authorship: true,
  show-table-of-contents: true,
)

//#set cite(style: "harvard-cite-them-right", form: "prose")
#set cite(style: "ieee", form: "normal")
// Edit this content to your liking
#set text(hyphenate: true)
#include "chapters/01_einleitung.typ"
#include "chapters/02_grundlagen.typ"
#include "chapters/03_business_understanding.typ"
#include "chapters/04_data_understanding.typ"
#include "chapters/05_data_preparation.typ"
#include "chapters/06_modeling.typ"
#include "chapters/07_evaluation.typ"
#include "chapters/08_deployment.typ"
#include "chapters/09_fazit.typ"
