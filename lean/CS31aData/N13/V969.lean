import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 969 = cert_data/n13/h13c.vec.part0969, entries 93478453248 .. 93574922239, chunks 22287 .. 22309
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v969 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0969" 385875968 16777216

end CS31aData.N13
