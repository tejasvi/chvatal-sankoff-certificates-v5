import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 593 = cert_data/n13/h13c.vec.part0593, entries 57206112256 .. 57302581247, chunks 13639 .. 13661
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v593 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0593" 385875968 16777216

end CS31aData.N13
