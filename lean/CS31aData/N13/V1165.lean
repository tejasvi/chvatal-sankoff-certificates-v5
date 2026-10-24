import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1165 = cert_data/n13/h13c.vec.part1165, entries 112386375680 .. 112482844671, chunks 26795 .. 26817
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1165 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1165" 385875968 16777216

end CS31aData.N13
