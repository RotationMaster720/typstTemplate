
#import "@preview/equate:0.3.0" : equate

#let namn = "namn"
#let mail = "namn@domain.se"
)
#let kurskod = "kurskod"
#let kursnamn = "kursnamn"
#let doctyp = "??"

// Functions
#let mattr(..columns) = math.mat(..array.zip(..columns))

#let fancy(content) = text(
  font: "TeX Gyre Chorus",
  content
)

#let warn() = [#box(
  width: 100%,
  fill: red,
  [\ \ #emoji.bomb #emoji.a #emoji.a #emoji.a #emoji.bomb \ \ .])]

#let cbox(content, caption) = figure(caption: caption, supplement: [Kodblock.],
    box(outset: 0.5em,radius: 0.5em, fill: gray.lighten(90%), stroke: 0.05em,
    content
    ) + v(0.2cm)
)

// Visual settings
#set text(lang: "sv")
#set math.equation(supplement: none, numbering: (..nums) => numbering("(1.1)", ..nums))
#set par(justify: true)
#set text(hyphenate: false)

#show math.equation: set block(breakable: true)

#set math.mat(delim:"[")
#set math.vec(delim:"[")

#set enum(
   tight: false,
   spacing:0.7cm,
   full: true, // necessary to receive all numbers at once, so we can know which level we are at
   numbering: (..nums) => {
     let nums = nums.pos()  // just positional args
     let num = nums.last()  // just the current level’s number
     let level = nums.len()  // level is the amount of numbers available

     // format for current level (or stop at i. If going too deep)
     let format = ("a)", "i.", "i.").at(calc.min(2, level - 1))
     let result = numbering(format, num) // formatted number
     if level < 3 { // first 2 levels for example
        strong(result)
     } else {
        result
     }
  }
)

//First side
#counter(page).update(0)
#align(center + horizon, text(17pt)[#image("Kth.png", width: 20%)])

#align(center + horizon, text(17pt)[

  *#kurskod \ 
  #kursnamn \
  #doctyp \
  #datetime.today().display()*
])
\
#line(
  start: (0pt,0pt), 
  end: (437pt,0pt), // Sidan går från -70 till 507
  stroke:1.5pt
) 
\
#let mailLink = "mailto:" + mail

#grid(
  columns: (1fr, 0fr),
  align(center)[
    #namn \
    Kungliga Tekniska Högskolan \
    #link(mailLink)
  ]
)
\ \ \ \ \
\ // Lätt justering av utseende

#set page(
  paper: "a4", 
  numbering: "1",
  footer: context[ 
  #align(center,[#line(length: 50em) ])
  #v(0cm)
  #grid(
    columns: (1fr, 3fr, 1fr),
    align: (left, center, right),
    [
  ] 
    , [#kurskod --- #kursnamn \ - #namn -], [ \ #counter(page).display(
    "1 / 1", both: true)
],
)
  
  #align(right ,[])
  ]
)
#pagebreak()
// Start of document
