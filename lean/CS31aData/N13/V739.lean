import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 739 = cert_data/n13/h13c.vec.part0739, entries 71290585088 .. 71387054079, chunks 16997 .. 17019
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v739 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0739" 385875968 16777216

end CS31aData.N13
