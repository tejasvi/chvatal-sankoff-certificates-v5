import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 891 = cert_data/n13/h13c.vec.part0891, entries 85953871872 .. 86050340863, chunks 20493 .. 20515
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v891 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0891" 385875968 16777216

end CS31aData.N13
