import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1529 = cert_data/n13/h13c.vec.part1529, entries 147501088768 .. 147597557759, chunks 35167 .. 35189
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1529 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1529" 385875968 16777216

end CS31aData.N13
