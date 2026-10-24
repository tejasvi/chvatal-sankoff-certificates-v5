import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 56 = cert_data/n13/h13c.vec.part0056, entries 5402263552 .. 5498732543, chunks 1288 .. 1310
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v56 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0056" 385875968 16777216

end CS31aData.N13
