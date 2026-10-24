import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 664 = cert_data/n13/h13c.vec.part0664, entries 64055410688 .. 64151879679, chunks 15272 .. 15294
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v664 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0664" 385875968 16777216

end CS31aData.N13
