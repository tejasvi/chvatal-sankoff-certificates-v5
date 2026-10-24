import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1142 = cert_data/n13/h13c.vec.part1142, entries 110167588864 .. 110264057855, chunks 26266 .. 26288
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1142 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1142" 385875968 16777216

end CS31aData.N13
