import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 410 = cert_data/n13/h13c.vec.part0410, entries 39552286720 .. 39648755711, chunks 9430 .. 9452
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v410 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0410" 385875968 16777216

end CS31aData.N13
