import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 544 = cert_data/n13/h13c.vec.part0544, entries 52479131648 .. 52575600639, chunks 12512 .. 12534
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v544 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0544" 385875968 16777216

end CS31aData.N13
