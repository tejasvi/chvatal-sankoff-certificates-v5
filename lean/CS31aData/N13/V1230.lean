import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1230 = cert_data/n13/h13c.vec.part1230, entries 118656860160 .. 118753329151, chunks 28290 .. 28312
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1230 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1230" 385875968 16777216

end CS31aData.N13
