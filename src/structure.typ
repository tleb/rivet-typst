#import "range.typ"
#import "util.typ"

#let make(
  name,
  bits,
  ranges,
  start: 0
) = {
  return (
    name: name,
    bits: bits,
    ranges: ranges,
    start: start
  )
}

#let load(id, data) = {
  let struct = (id: id)
  let ranges = (:)

  for (range-span, range-data) in data.ranges {
    let (start, end) = range.parse-span(str(range-span))
    ranges.insert(
      range.key(start, end),
      range.load(start, end, range-data)
    )
  }

  for range_ in ranges.values() {
    if range_.values != none and range_.depends-on != none {
      let depends-key = range.key(..range_.depends-on)
      let depends-range = ranges.at(depends-key)
      let bits = range.bits(depends-range)
      let values = (:)
      for (v, d) in range_.values {
        v = util.z-fill(str(int(v)), bits)
        values.insert(v, d)
      }
    }
  }

  return make(
    id,
    int(data.bits),
    ranges,
    start: data.at("start", default: 0)
  )
}

#let get-sorted-ranges(struct) = {
  let ranges = struct.ranges.values()
  return ranges.sorted(key: r => r.end)
}