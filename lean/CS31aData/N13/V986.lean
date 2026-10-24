import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 986 = cert_data/n13/h13c.vec.part0986, entries 95118426112 .. 95214895103, chunks 22678 .. 22700
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v986 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0986" 385875968 16777216

end CS31aData.N13
