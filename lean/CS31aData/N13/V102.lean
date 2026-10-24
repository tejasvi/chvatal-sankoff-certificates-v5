import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 102 = cert_data/n13/h13c.vec.part0102, entries 9839837184 .. 9936306175, chunks 2346 .. 2368
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v102 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0102" 385875968 16777216

end CS31aData.N13
