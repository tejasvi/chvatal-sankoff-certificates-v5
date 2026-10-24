import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1079 = cert_data/n13/h13c.vec.part1079, entries 104090042368 .. 104186511359, chunks 24817 .. 24839
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1079 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1079" 385875968 16777216

end CS31aData.N13
