import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1025 = cert_data/n13/h13c.vec.part1025, entries 98880716800 .. 98977185791, chunks 23575 .. 23597
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1025 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1025" 385875968 16777216

end CS31aData.N13
