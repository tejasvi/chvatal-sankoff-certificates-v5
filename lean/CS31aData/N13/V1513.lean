import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1513 = cert_data/n13/h13c.vec.part1513, entries 145957584896 .. 146054053887, chunks 34799 .. 34821
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1513 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1513" 385875968 16777216

end CS31aData.N13
