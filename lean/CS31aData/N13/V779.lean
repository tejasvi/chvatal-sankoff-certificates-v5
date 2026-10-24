import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 779 = cert_data/n13/h13c.vec.part0779, entries 75149344768 .. 75245813759, chunks 17917 .. 17939
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v779 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0779" 385875968 16777216

end CS31aData.N13
