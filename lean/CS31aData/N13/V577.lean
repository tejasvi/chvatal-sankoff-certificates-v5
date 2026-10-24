import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 577 = cert_data/n13/h13c.vec.part0577, entries 55662608384 .. 55759077375, chunks 13271 .. 13293
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v577 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0577" 385875968 16777216

end CS31aData.N13
