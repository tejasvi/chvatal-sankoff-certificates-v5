import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1205 = cert_data/n13/h13c.vec.part1205, entries 116245135360 .. 116341604351, chunks 27715 .. 27737
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1205 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1205" 385875968 16777216

end CS31aData.N13
