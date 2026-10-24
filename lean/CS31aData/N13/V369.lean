import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 369 = cert_data/n13/h13c.vec.part0369, entries 35597058048 .. 35693527039, chunks 8487 .. 8509
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v369 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0369" 385875968 16777216

end CS31aData.N13
