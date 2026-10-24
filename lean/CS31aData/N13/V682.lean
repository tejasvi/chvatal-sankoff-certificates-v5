import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 682 = cert_data/n13/h13c.vec.part0682, entries 65791852544 .. 65888321535, chunks 15686 .. 15708
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v682 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0682" 385875968 16777216

end CS31aData.N13
