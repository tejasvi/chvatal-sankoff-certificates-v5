import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 642 = cert_data/n13/h13c.vec.part0642, entries 61933092864 .. 62029561855, chunks 14766 .. 14788
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v642 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0642" 385875968 16777216

end CS31aData.N13
