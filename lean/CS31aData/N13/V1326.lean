import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1326 = cert_data/n13/h13c.vec.part1326, entries 127917883392 .. 128014352383, chunks 30498 .. 30520
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1326 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1326" 385875968 16777216

end CS31aData.N13
