import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1385 = cert_data/n13/h13c.vec.part1385, entries 133609553920 .. 133706022911, chunks 31855 .. 31877
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1385 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1385" 385875968 16777216

end CS31aData.N13
