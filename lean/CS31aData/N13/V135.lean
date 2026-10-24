import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 135 = cert_data/n13/h13c.vec.part0135, entries 13023313920 .. 13119782911, chunks 3105 .. 3127
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v135 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0135" 385875968 16777216

end CS31aData.N13
