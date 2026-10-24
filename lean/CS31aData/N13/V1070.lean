import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1070 = cert_data/n13/h13c.vec.part1070, entries 103221821440 .. 103318290431, chunks 24610 .. 24632
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1070 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1070" 385875968 16777216

end CS31aData.N13
