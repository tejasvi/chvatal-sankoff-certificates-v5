import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 451 = cert_data/n13/h13c.vec.part0451, entries 43507515392 .. 43603984383, chunks 10373 .. 10395
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v451 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0451" 385875968 16777216

end CS31aData.N13
