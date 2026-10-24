import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1149 = cert_data/n13/h13c.vec.part1149, entries 110842871808 .. 110939340799, chunks 26427 .. 26449
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1149 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1149" 385875968 16777216

end CS31aData.N13
