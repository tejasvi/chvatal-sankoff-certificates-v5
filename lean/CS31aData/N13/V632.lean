import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 632 = cert_data/n13/h13c.vec.part0632, entries 60968402944 .. 61064871935, chunks 14536 .. 14558
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v632 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0632" 385875968 16777216

end CS31aData.N13
