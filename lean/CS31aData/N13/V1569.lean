import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1569 = cert_data/n13/h13c.vec.part1569, entries 151359848448 .. 151456317439, chunks 36087 .. 36109
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1569 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1569" 385875968 16777216

end CS31aData.N13
