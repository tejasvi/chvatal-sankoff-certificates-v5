import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 288 = cert_data/n13/h13c.vec.part0288, entries 27783069696 .. 27879538687, chunks 6624 .. 6646
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v288 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0288" 385875968 16777216

end CS31aData.N13
