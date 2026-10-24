import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 561 = cert_data/n13/h13c.vec.part0561, entries 54119104512 .. 54215573503, chunks 12903 .. 12925
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v561 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0561" 385875968 16777216

end CS31aData.N13
