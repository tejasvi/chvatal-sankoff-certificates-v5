import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 385 = cert_data/n13/h13c.vec.part0385, entries 37140561920 .. 37237030911, chunks 8855 .. 8877
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v385 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0385" 385875968 16777216

end CS31aData.N13
