import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 608 = cert_data/n13/h13c.vec.part0608, entries 58653147136 .. 58749616127, chunks 13984 .. 14006
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v608 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0608" 385875968 16777216

end CS31aData.N13
