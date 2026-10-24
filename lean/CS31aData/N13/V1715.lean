import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1715 = cert_data/n13/h13c.vec.part1715, entries 165444321280 .. 165540790271, chunks 39445 .. 39467
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1715 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1715" 385875968 16777216

end CS31aData.N13
