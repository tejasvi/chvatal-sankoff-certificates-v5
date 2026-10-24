import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 257 = cert_data/n13/h13c.vec.part0257, entries 24792530944 .. 24888999935, chunks 5911 .. 5933
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v257 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0257" 385875968 16777216

end CS31aData.N13
