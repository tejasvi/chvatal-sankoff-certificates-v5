import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 421 = cert_data/n13/h13c.vec.part0421, entries 40613445632 .. 40709914623, chunks 9683 .. 9705
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v421 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0421" 385875968 16777216

end CS31aData.N13
