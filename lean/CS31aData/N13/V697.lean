import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 697 = cert_data/n13/h13c.vec.part0697, entries 67238887424 .. 67335356415, chunks 16031 .. 16053
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v697 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0697" 385875968 16777216

end CS31aData.N13
