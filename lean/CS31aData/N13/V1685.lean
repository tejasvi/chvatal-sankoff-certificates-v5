import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1685 = cert_data/n13/h13c.vec.part1685, entries 162550251520 .. 162646720511, chunks 38755 .. 38777
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1685 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1685" 385875968 16777216

end CS31aData.N13
