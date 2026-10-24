import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 30 = cert_data/n13/h13c.vec.part0030, entries 2894069760 .. 2990538751, chunks 690 .. 712
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v30 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0030" 385875968 16777216

end CS31aData.N13
