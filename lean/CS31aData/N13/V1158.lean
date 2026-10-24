import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1158 = cert_data/n13/h13c.vec.part1158, entries 111711092736 .. 111807561727, chunks 26634 .. 26656
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1158 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1158" 385875968 16777216

end CS31aData.N13
