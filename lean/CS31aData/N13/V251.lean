import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 251 = cert_data/n13/h13c.vec.part0251, entries 24213716992 .. 24310185983, chunks 5773 .. 5795
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v251 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0251" 385875968 16777216

end CS31aData.N13
