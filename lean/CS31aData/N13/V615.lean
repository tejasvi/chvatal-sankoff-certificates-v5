import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 615 = cert_data/n13/h13c.vec.part0615, entries 59328430080 .. 59424899071, chunks 14145 .. 14167
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v615 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0615" 385875968 16777216

end CS31aData.N13
