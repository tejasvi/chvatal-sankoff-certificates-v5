import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1279 = cert_data/n13/h13c.vec.part1279, entries 123383840768 .. 123480309759, chunks 29417 .. 29439
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1279 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1279" 385875968 16777216

end CS31aData.N13
