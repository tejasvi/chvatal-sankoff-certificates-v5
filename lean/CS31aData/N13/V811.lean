import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 811 = cert_data/n13/h13c.vec.part0811, entries 78236352512 .. 78332821503, chunks 18653 .. 18675
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v811 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0811" 385875968 16777216

end CS31aData.N13
