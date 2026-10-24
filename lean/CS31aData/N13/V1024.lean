import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1024 = cert_data/n13/h13c.vec.part1024, entries 98784247808 .. 98880716799, chunks 23552 .. 23574
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1024 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1024" 385875968 16777216

end CS31aData.N13
