import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 989 = cert_data/n13/h13c.vec.part0989, entries 95407833088 .. 95504302079, chunks 22747 .. 22769
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v989 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0989" 385875968 16777216

end CS31aData.N13
