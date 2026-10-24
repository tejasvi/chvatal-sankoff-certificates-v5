import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1635 = cert_data/n13/h13c.vec.part1635, entries 157726801920 .. 157823270911, chunks 37605 .. 37627
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1635 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1635" 385875968 16777216

end CS31aData.N13
