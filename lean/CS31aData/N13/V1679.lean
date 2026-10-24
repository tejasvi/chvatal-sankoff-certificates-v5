import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1679 = cert_data/n13/h13c.vec.part1679, entries 161971437568 .. 162067906559, chunks 38617 .. 38639
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1679 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1679" 385875968 16777216

end CS31aData.N13
