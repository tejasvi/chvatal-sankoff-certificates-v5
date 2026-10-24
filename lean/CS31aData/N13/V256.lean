import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 256 = cert_data/n13/h13c.vec.part0256, entries 24696061952 .. 24792530943, chunks 5888 .. 5910
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v256 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0256" 385875968 16777216

end CS31aData.N13
