import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 164 = cert_data/n13/h13c.vec.part0164, entries 15820914688 .. 15917383679, chunks 3772 .. 3794
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v164 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0164" 385875968 16777216

end CS31aData.N13
