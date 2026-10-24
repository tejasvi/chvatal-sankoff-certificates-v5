import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1596 = cert_data/n13/h13c.vec.part1596, entries 153964511232 .. 154060980223, chunks 36708 .. 36730
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1596 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1596" 385875968 16777216

end CS31aData.N13
