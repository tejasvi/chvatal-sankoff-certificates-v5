import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1464 = cert_data/n13/h13c.vec.part1464, entries 141230604288 .. 141327073279, chunks 33672 .. 33694
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1464 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1464" 385875968 16777216

end CS31aData.N13
