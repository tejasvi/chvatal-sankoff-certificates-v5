import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1684 = cert_data/n13/h13c.vec.part1684, entries 162453782528 .. 162550251519, chunks 38732 .. 38754
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1684 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1684" 385875968 16777216

end CS31aData.N13
