import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 419 = cert_data/n13/h13c.vec.part0419, entries 40420507648 .. 40516976639, chunks 9637 .. 9659
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v419 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0419" 385875968 16777216

end CS31aData.N13
