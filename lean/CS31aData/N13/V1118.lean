import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1118 = cert_data/n13/h13c.vec.part1118, entries 107852333056 .. 107948802047, chunks 25714 .. 25736
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1118 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1118" 385875968 16777216

end CS31aData.N13
