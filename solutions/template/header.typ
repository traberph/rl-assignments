#import "authors.typ": authors

#let submission(
  exerciseNumber: 1,
  course: "Reinforcement Learning",
  authors: authors,
  date: datetime.today().display("[day].[month].[year]"),
  body,
) = {
  let documentTitle = "Exercise Sheet " + str(exerciseNumber)

  set document(
    title: documentTitle,
    author: authors.map(a => a.name),
  )

  set page(
    paper: "a4",
    margin: 1.5cm,
  )

  set text(
    font: "New Computer Modern",
    size: 11pt,
  )

  set par(
    justify: true,
    leading: 0.65em,
  )

  set heading(numbering: "1.a.1)")

  // Date at the top right and title
  grid(
    columns: (1fr, 4fr, 1fr),
    align: (left, center, right),
    column-gutter: 0pt,
    [],
    [
      #text(size: 22pt, weight: "bold")[#documentTitle]
    ],
    [
      #text(size: 11pt)[#date]
    ],
  )

  line(length: 100%, stroke: 0.8pt)

  // authors
  set text(size: 11pt)
  grid(
    align: center,
    columns: (1fr, 1fr, 1fr),
    column-gutter: 1em,
    row-gutter: 0.2em,
    ..authors.map(a => [
      #a.name \
      #text(size: 9pt)[#a.matriculation]
    ]),
  )

  set text(size: 11pt)

  line(length: 100%, stroke: 0.8pt)

  body
}
