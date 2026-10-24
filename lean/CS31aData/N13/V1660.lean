import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1660 = cert_data/n13/h13c.vec.part1660, entries 160138526720 .. 160234995711, chunks 38180 .. 38202
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1660 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1660" 385875968 16777216

end CS31aData.N13
