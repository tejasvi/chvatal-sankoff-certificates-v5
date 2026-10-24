import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 239 = cert_data/n13/h13c.vec.part0239, entries 23056089088 .. 23152558079, chunks 5497 .. 5519
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v239 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0239" 385875968 16777216

end CS31aData.N13
