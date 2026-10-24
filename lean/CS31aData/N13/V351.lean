import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 351 = cert_data/n13/h13c.vec.part0351, entries 33860616192 .. 33957085183, chunks 8073 .. 8095
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v351 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0351" 385875968 16777216

end CS31aData.N13
