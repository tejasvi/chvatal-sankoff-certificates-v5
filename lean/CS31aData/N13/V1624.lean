import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1624 = cert_data/n13/h13c.vec.part1624, entries 156665643008 .. 156762111999, chunks 37352 .. 37374
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1624 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1624" 385875968 16777216

end CS31aData.N13
