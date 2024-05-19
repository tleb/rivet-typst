#import "../src/lib.typ": *

#let test = schema.load("/gallery/test.yaml")
#schema.render(test, config: config.blueprint(
  full-page: true,
  default-font-family: "Ubuntu Mono"
))