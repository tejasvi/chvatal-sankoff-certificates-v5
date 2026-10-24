import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1003 = cert_data/n13/h13c.vec.part1003, entries 96758398976 .. 96854867967, chunks 23069 .. 23091
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1003 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1003" 385875968 16777216

end CS31aData.N13
