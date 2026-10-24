import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 970 = cert_data/n13/h13c.vec.part0970, entries 93574922240 .. 93671391231, chunks 22310 .. 22332
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v970 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0970" 385875968 16777216

end CS31aData.N13
