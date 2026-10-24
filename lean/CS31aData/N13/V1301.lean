import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1301 = cert_data/n13/h13c.vec.part1301, entries 125506158592 .. 125602627583, chunks 29923 .. 29945
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1301 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1301" 385875968 16777216

end CS31aData.N13
