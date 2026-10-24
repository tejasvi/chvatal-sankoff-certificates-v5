import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 24 = cert_data/n13/h13c.vec.part0024, entries 2315255808 .. 2411724799, chunks 552 .. 574
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v24 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0024" 385875968 16777216

end CS31aData.N13
