import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 944 = cert_data/n13/h13c.vec.part0944, entries 91066728448 .. 91163197439, chunks 21712 .. 21734
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v944 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0944" 385875968 16777216

end CS31aData.N13
