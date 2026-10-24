import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 798 = cert_data/n13/h13c.vec.part0798, entries 76982255616 .. 77078724607, chunks 18354 .. 18376
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v798 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0798" 385875968 16777216

end CS31aData.N13
