import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 156 = cert_data/n13/h13c.vec.part0156, entries 15049162752 .. 15145631743, chunks 3588 .. 3610
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v156 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0156" 385875968 16777216

end CS31aData.N13
