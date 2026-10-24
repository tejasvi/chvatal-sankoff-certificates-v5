import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1310 = cert_data/n13/h13c.vec.part1310, entries 126374379520 .. 126470848511, chunks 30130 .. 30152
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1310 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1310" 385875968 16777216

end CS31aData.N13
