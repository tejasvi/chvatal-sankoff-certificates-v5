import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1146 = cert_data/n13/h13c.vec.part1146, entries 110553464832 .. 110649933823, chunks 26358 .. 26380
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1146 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1146" 385875968 16777216

end CS31aData.N13
