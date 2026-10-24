import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 113 = cert_data/n13/h13c.vec.part0113, entries 10900996096 .. 10997465087, chunks 2599 .. 2621
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v113 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0113" 385875968 16777216

end CS31aData.N13
