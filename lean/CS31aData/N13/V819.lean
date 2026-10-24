import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 819 = cert_data/n13/h13c.vec.part0819, entries 79008104448 .. 79104573439, chunks 18837 .. 18859
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v819 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0819" 385875968 16777216

end CS31aData.N13
