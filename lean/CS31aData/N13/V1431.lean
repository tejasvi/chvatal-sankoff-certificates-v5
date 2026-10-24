import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1431 = cert_data/n13/h13c.vec.part1431, entries 138047127552 .. 138143596543, chunks 32913 .. 32935
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1431 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1431" 385875968 16777216

end CS31aData.N13
