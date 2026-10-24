import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1169 = cert_data/n13/h13c.vec.part1169, entries 112772251648 .. 112868720639, chunks 26887 .. 26909
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1169 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1169" 385875968 16777216

end CS31aData.N13
