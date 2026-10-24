import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1545 = cert_data/n13/h13c.vec.part1545, entries 149044592640 .. 149141061631, chunks 35535 .. 35557
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1545 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1545" 385875968 16777216

end CS31aData.N13
