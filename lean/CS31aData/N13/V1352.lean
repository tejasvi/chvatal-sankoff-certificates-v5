import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1352 = cert_data/n13/h13c.vec.part1352, entries 130426077184 .. 130522546175, chunks 31096 .. 31118
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1352 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1352" 385875968 16777216

end CS31aData.N13
