import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 907 = cert_data/n13/h13c.vec.part0907, entries 87497375744 .. 87593844735, chunks 20861 .. 20883
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v907 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0907" 385875968 16777216

end CS31aData.N13
