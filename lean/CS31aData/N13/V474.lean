import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 474 = cert_data/n13/h13c.vec.part0474, entries 45726302208 .. 45822771199, chunks 10902 .. 10924
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v474 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0474" 385875968 16777216

end CS31aData.N13
