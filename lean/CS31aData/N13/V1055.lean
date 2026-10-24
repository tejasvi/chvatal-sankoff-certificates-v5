import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1055 = cert_data/n13/h13c.vec.part1055, entries 101774786560 .. 101871255551, chunks 24265 .. 24287
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1055 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1055" 385875968 16777216

end CS31aData.N13
