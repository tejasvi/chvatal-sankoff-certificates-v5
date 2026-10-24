import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 415 = cert_data/n13/h13c.vec.part0415, entries 40034631680 .. 40131100671, chunks 9545 .. 9567
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v415 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0415" 385875968 16777216

end CS31aData.N13
