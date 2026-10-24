import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 703 = cert_data/n13/h13c.vec.part0703, entries 67817701376 .. 67914170367, chunks 16169 .. 16191
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v703 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0703" 385875968 16777216

end CS31aData.N13
