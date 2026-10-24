import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 509 = cert_data/n13/h13c.vec.part0509, entries 49102716928 .. 49199185919, chunks 11707 .. 11729
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v509 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0509" 385875968 16777216

end CS31aData.N13
