import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1480 = cert_data/n13/h13c.vec.part1480, entries 142774108160 .. 142870577151, chunks 34040 .. 34062
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1480 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1480" 385875968 16777216

end CS31aData.N13
