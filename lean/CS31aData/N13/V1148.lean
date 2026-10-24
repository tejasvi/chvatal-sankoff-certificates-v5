import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1148 = cert_data/n13/h13c.vec.part1148, entries 110746402816 .. 110842871807, chunks 26404 .. 26426
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1148 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1148" 385875968 16777216

end CS31aData.N13
