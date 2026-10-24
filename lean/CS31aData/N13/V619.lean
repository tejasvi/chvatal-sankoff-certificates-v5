import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 619 = cert_data/n13/h13c.vec.part0619, entries 59714306048 .. 59810775039, chunks 14237 .. 14259
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v619 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0619" 385875968 16777216

end CS31aData.N13
