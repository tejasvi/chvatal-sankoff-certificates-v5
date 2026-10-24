import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1088 = cert_data/n13/h13c.vec.part1088, entries 104958263296 .. 105054732287, chunks 25024 .. 25046
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1088 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1088" 385875968 16777216

end CS31aData.N13
