import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1299 = cert_data/n13/h13c.vec.part1299, entries 125313220608 .. 125409689599, chunks 29877 .. 29899
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1299 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1299" 385875968 16777216

end CS31aData.N13
