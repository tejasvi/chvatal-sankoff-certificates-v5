import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 472 = cert_data/n13/h13c.vec.part0472, entries 45533364224 .. 45629833215, chunks 10856 .. 10878
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v472 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0472" 385875968 16777216

end CS31aData.N13
