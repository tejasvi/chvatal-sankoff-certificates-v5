import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 283 = cert_data/n13/h13c.vec.part0283, entries 27300724736 .. 27397193727, chunks 6509 .. 6531
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v283 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0283" 385875968 16777216

end CS31aData.N13
