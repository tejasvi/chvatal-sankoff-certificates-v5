import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 663 = cert_data/n13/h13c.vec.part0663, entries 63958941696 .. 64055410687, chunks 15249 .. 15271
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v663 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0663" 385875968 16777216

end CS31aData.N13
