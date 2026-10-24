import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1606 = cert_data/n13/h13c.vec.part1606, entries 154929201152 .. 155025670143, chunks 36938 .. 36960
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1606 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1606" 385875968 16777216

end CS31aData.N13
