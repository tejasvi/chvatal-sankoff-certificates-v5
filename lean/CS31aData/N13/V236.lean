import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 236 = cert_data/n13/h13c.vec.part0236, entries 22766682112 .. 22863151103, chunks 5428 .. 5450
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v236 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0236" 385875968 16777216

end CS31aData.N13
