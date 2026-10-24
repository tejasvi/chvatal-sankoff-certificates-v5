import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 190 = cert_data/n13/h13c.vec.part0190, entries 18329108480 .. 18425577471, chunks 4370 .. 4392
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v190 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0190" 385875968 16777216

end CS31aData.N13
