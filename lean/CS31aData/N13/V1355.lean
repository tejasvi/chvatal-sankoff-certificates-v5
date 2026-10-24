import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1355 = cert_data/n13/h13c.vec.part1355, entries 130715484160 .. 130811953151, chunks 31165 .. 31187
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1355 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1355" 385875968 16777216

end CS31aData.N13
