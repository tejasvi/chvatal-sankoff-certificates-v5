import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 849 = cert_data/n13/h13c.vec.part0849, entries 81902174208 .. 81998643199, chunks 19527 .. 19549
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v849 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0849" 385875968 16777216

end CS31aData.N13
