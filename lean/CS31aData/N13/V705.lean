import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 705 = cert_data/n13/h13c.vec.part0705, entries 68010639360 .. 68107108351, chunks 16215 .. 16237
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v705 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0705" 385875968 16777216

end CS31aData.N13
