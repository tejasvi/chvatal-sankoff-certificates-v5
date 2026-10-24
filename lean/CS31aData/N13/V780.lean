import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 780 = cert_data/n13/h13c.vec.part0780, entries 75245813760 .. 75342282751, chunks 17940 .. 17962
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v780 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0780" 385875968 16777216

end CS31aData.N13
