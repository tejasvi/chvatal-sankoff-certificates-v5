import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 119 = cert_data/n13/h13c.vec.part0119, entries 11479810048 .. 11576279039, chunks 2737 .. 2759
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v119 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0119" 385875968 16777216

end CS31aData.N13
