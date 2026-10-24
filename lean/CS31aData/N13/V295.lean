import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 295 = cert_data/n13/h13c.vec.part0295, entries 28458352640 .. 28554821631, chunks 6785 .. 6807
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v295 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0295" 385875968 16777216

end CS31aData.N13
