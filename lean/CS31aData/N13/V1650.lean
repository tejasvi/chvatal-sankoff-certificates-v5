import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1650 = cert_data/n13/h13c.vec.part1650, entries 159173836800 .. 159270305791, chunks 37950 .. 37972
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1650 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1650" 385875968 16777216

end CS31aData.N13
