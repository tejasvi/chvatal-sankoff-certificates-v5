import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 124 = cert_data/n13/h13c.vec.part0124, entries 11962155008 .. 12058623999, chunks 2852 .. 2874
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v124 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0124" 385875968 16777216

end CS31aData.N13
