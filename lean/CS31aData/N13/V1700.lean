import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1700 = cert_data/n13/h13c.vec.part1700, entries 163997286400 .. 164093755391, chunks 39100 .. 39122
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1700 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1700" 385875968 16777216

end CS31aData.N13
