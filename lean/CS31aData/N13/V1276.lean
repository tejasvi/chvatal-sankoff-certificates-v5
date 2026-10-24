import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1276 = cert_data/n13/h13c.vec.part1276, entries 123094433792 .. 123190902783, chunks 29348 .. 29370
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1276 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1276" 385875968 16777216

end CS31aData.N13
