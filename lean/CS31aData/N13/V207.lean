import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 207 = cert_data/n13/h13c.vec.part0207, entries 19969081344 .. 20065550335, chunks 4761 .. 4783
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v207 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0207" 385875968 16777216

end CS31aData.N13
