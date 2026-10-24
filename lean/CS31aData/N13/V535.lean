import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 535 = cert_data/n13/h13c.vec.part0535, entries 51610910720 .. 51707379711, chunks 12305 .. 12327
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v535 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0535" 385875968 16777216

end CS31aData.N13
