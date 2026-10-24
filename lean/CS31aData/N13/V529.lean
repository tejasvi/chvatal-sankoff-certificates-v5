import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 529 = cert_data/n13/h13c.vec.part0529, entries 51032096768 .. 51128565759, chunks 12167 .. 12189
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v529 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0529" 385875968 16777216

end CS31aData.N13
