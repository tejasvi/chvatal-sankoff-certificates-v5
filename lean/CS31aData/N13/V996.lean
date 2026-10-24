import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 996 = cert_data/n13/h13c.vec.part0996, entries 96083116032 .. 96179585023, chunks 22908 .. 22930
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v996 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0996" 385875968 16777216

end CS31aData.N13
