#import "../src/lib.typ": *

#let test-yaml = schema.load("/gallery/test.yaml")
#schema.render(test-yaml, config: config.config(
  full-page: true
))

#let test-json = schema.load("/gallery/test.json")
#schema.render(test-json, config: config.blueprint(
  full-page: true
))

#let test-xml = schema.load("/gallery/test.xml")
#schema.render(test-xml, config: config.dark(
  full-page: true
))

#let test-raw = schema.load(```yaml
structures:
  main:
    bits: 4
    ranges:
      3-0:
        name: test
```)
#schema.render(test-raw, config: config.config(
  full-page: true
))