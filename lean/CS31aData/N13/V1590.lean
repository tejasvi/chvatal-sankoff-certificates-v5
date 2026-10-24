import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1590 = cert_data/n13/h13c.vec.part1590, entries 153385697280 .. 153482166271, chunks 36570 .. 36592
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1590 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1590" 385875968 16777216

end CS31aData.N13
