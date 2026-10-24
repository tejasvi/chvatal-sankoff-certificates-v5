import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 289 = cert_data/n13/h13c.vec.part0289, entries 27879538688 .. 27976007679, chunks 6647 .. 6669
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v289 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0289" 385875968 16777216

end CS31aData.N13
