import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 875 = cert_data/n13/h13c.vec.part0875, entries 84410368000 .. 84506836991, chunks 20125 .. 20147
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v875 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0875" 385875968 16777216

end CS31aData.N13
