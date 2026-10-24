import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 656 = cert_data/n13/h13c.vec.part0656, entries 63283658752 .. 63380127743, chunks 15088 .. 15110
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v656 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0656" 385875968 16777216

end CS31aData.N13
