import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 896 = cert_data/n13/h13c.vec.part0896, entries 86436216832 .. 86532685823, chunks 20608 .. 20630
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v896 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0896" 385875968 16777216

end CS31aData.N13
