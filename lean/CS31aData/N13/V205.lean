import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 205 = cert_data/n13/h13c.vec.part0205, entries 19776143360 .. 19872612351, chunks 4715 .. 4737
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v205 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0205" 385875968 16777216

end CS31aData.N13
