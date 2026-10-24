import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1202 = cert_data/n13/h13c.vec.part1202, entries 115955728384 .. 116052197375, chunks 27646 .. 27668
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1202 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1202" 385875968 16777216

end CS31aData.N13
