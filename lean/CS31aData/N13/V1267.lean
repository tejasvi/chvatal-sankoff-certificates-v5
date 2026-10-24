import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1267 = cert_data/n13/h13c.vec.part1267, entries 122226212864 .. 122322681855, chunks 29141 .. 29163
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1267 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1267" 385875968 16777216

end CS31aData.N13
