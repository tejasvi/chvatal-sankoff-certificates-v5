import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 177 = cert_data/n13/h13c.vec.part0177, entries 17075011584 .. 17171480575, chunks 4071 .. 4093
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v177 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0177" 385875968 16777216

end CS31aData.N13
