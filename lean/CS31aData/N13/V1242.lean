import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1242 = cert_data/n13/h13c.vec.part1242, entries 119814488064 .. 119910957055, chunks 28566 .. 28588
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1242 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1242" 385875968 16777216

end CS31aData.N13
