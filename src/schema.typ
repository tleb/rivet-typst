#import "config.typ" as conf
#import "renderer.typ"
#import "structure.typ"

#let valid-extensions = ("yaml", "json", "xml")

#let parse-xml(path) = {
  panic("TODO")
}

#let parse-file(path) = {
  let ext = path.split(".").last()

  if not ext in valid-extensions {
    let fmts = valid-extensions.map(fmt => "." + fmt).join(", ")
    fmts = "(" + fmts + ")"
    panic("." + ext + " files are not supported. Valid formats: " + fmts)
  }

  if ext == "yaml" {
    return yaml(path)
  } else if ext == "json" {
    return json(path)
  } else if ext == "xml" {
    return parse-xml(path)
  }
}

#let load(path-or-schema, config: auto) = {
  let schema = if type(path-or-schema) == str {
    parse-file(path-or-schema)
  } else {
    parse-raw(path-or-schema)
  }

  let structures = (:)
  for (id, data) in schema.structures {
    id = str(id)
    structures.insert(id, structure.load(id, data))
  }
  return structures
}

#let render(structures, config: auto) = {
  if config == auto {
    config = conf.config()
  }
  let renderer_ = renderer.make(config)
  (renderer_.render)(structures)
}