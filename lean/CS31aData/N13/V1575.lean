import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1575 = cert_data/n13/h13c.vec.part1575, entries 151938662400 .. 152035131391, chunks 36225 .. 36247
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1575 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1575" 385875968 16777216

end CS31aData.N13
