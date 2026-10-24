import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1107 = cert_data/n13/h13c.vec.part1107, entries 106791174144 .. 106887643135, chunks 25461 .. 25483
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1107 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1107" 385875968 16777216

end CS31aData.N13
