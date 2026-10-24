import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 545 = cert_data/n13/h13c.vec.part0545, entries 52575600640 .. 52672069631, chunks 12535 .. 12557
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v545 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0545" 385875968 16777216

end CS31aData.N13
