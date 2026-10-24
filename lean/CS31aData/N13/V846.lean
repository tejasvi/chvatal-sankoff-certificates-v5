import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 846 = cert_data/n13/h13c.vec.part0846, entries 81612767232 .. 81709236223, chunks 19458 .. 19480
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v846 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0846" 385875968 16777216

end CS31aData.N13
