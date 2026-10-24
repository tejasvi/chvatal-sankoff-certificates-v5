import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1029 = cert_data/n13/h13c.vec.part1029, entries 99266592768 .. 99363061759, chunks 23667 .. 23689
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1029 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1029" 385875968 16777216

end CS31aData.N13
