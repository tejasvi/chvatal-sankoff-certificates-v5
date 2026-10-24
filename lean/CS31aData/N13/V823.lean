import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 823 = cert_data/n13/h13c.vec.part0823, entries 79393980416 .. 79490449407, chunks 18929 .. 18951
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v823 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0823" 385875968 16777216

end CS31aData.N13
