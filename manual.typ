#import "@preview/tidy:0.3.0"
#import "src/lib.typ"
#import "src/schema.typ"
#import "docs/examples.typ"

#set heading(numbering: (..num) => if num.pos().len() < 4 {
  numbering("1.1", ..num)
})
#{
  outline(indent: true, depth: 3)
}

#set page(numbering: "1/1", header: align(right)[rivet #sym.dash.em v#lib.version])

#let doc-ref(target, full: false, var: false) = {
  let (module, func) = target.split(".")
  let label-name = module + func
  let display-name = func
  if full {
    display-name = target
  }
  if not var {
    label-name += "()"
    display-name += "()"
  }
  link(label(label-name))[#display-name]
}

#show link: set text(blue)

= Introduction

This package provides a way to make beautiful register diagrams using the CeTZ package. It can be used to document Assembly instructions or binary registers

This is a port of the #link("https://git.kb28.ch/HEL/rivet")[homonymous Python script] for Typst. For more information on the schema format, please check out the original project's #link("https://git.kb28.ch/HEL/rivet/src/branch/main/format.md")[format.md]

= Usage

Simply import `schema` from #link("src/lib.typ") and call `schema.load` to parse a schema description. Then use `schema.render` to render it, et voilà !
#pad(left: 1em)[```typ
#import "src/lib.typ": schema
#let doc = schema.load("path/to/schema.typ")
#schema.render(doc)
```]

= Config presets

Aside from the default config, some example presets are also provided:
- #doc-ref("config.config", full: true): the default theme, black on white
  #examples.config-config
- #doc-ref("config.dark", full: true): a dark theme, with white text and lines on a black background
  #examples.config-dark
- #doc-ref("config.blueprint", full: true): a blueprint theme, with white text and lines on a blue background
  #examples.config-blueprint

#pagebreak(weak: true)

= Reference

#let doc-config = tidy.parse-module(
  read("docs/config.typ"),
  name: "config",
  scope: (
    doc-ref: doc-ref
  )
)
#tidy.show-module(doc-config, sort-functions: false)

#pagebreak()

#let doc-schema = tidy.parse-module(
  read("docs/schema.typ"),
  name: "schema",
  scope: (
    schema: schema,
    doc-ref: doc-ref
  )
)
#tidy.show-module(doc-schema, sort-functions: false)