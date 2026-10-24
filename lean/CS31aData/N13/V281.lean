import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 281 = cert_data/n13/h13c.vec.part0281, entries 27107786752 .. 27204255743, chunks 6463 .. 6485
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v281 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0281" 385875968 16777216

end CS31aData.N13
