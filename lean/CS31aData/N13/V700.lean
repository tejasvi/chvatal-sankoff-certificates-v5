import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 700 = cert_data/n13/h13c.vec.part0700, entries 67528294400 .. 67624763391, chunks 16100 .. 16122
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v700 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0700" 385875968 16777216

end CS31aData.N13
