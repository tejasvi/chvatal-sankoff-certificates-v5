import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1536 = cert_data/n13/h13c.vec.part1536, entries 148176371712 .. 148272840703, chunks 35328 .. 35350
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1536 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1536" 385875968 16777216

end CS31aData.N13
