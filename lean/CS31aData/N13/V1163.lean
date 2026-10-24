import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1163 = cert_data/n13/h13c.vec.part1163, entries 112193437696 .. 112289906687, chunks 26749 .. 26771
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1163 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1163" 385875968 16777216

end CS31aData.N13
