import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 865 = cert_data/n13/h13c.vec.part0865, entries 83445678080 .. 83542147071, chunks 19895 .. 19917
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v865 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0865" 385875968 16777216

end CS31aData.N13
