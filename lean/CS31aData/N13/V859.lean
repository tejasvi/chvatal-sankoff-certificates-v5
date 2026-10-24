import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 859 = cert_data/n13/h13c.vec.part0859, entries 82866864128 .. 82963333119, chunks 19757 .. 19779
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v859 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0859" 385875968 16777216

end CS31aData.N13
