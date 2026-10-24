import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 252 = cert_data/n13/h13c.vec.part0252, entries 24310185984 .. 24406654975, chunks 5796 .. 5818
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v252 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0252" 385875968 16777216

end CS31aData.N13
