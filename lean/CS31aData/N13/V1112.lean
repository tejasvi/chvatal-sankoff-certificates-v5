import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1112 = cert_data/n13/h13c.vec.part1112, entries 107273519104 .. 107369988095, chunks 25576 .. 25598
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1112 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1112" 385875968 16777216

end CS31aData.N13
