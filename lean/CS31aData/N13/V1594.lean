import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1594 = cert_data/n13/h13c.vec.part1594, entries 153771573248 .. 153868042239, chunks 36662 .. 36684
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1594 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1594" 385875968 16777216

end CS31aData.N13
