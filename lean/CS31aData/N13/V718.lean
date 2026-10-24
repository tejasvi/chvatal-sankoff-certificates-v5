import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 718 = cert_data/n13/h13c.vec.part0718, entries 69264736256 .. 69361205247, chunks 16514 .. 16536
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v718 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0718" 385875968 16777216

end CS31aData.N13
