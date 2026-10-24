import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 62 = cert_data/n13/h13c.vec.part0062, entries 5981077504 .. 6077546495, chunks 1426 .. 1448
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v62 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0062" 385875968 16777216

end CS31aData.N13
