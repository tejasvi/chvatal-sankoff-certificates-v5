import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1365 = cert_data/n13/h13c.vec.part1365, entries 131680174080 .. 131776643071, chunks 31395 .. 31417
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1365 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1365" 385875968 16777216

end CS31aData.N13
