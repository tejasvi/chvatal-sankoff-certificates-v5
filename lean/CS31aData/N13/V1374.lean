import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1374 = cert_data/n13/h13c.vec.part1374, entries 132548395008 .. 132644863999, chunks 31602 .. 31624
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1374 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1374" 385875968 16777216

end CS31aData.N13
