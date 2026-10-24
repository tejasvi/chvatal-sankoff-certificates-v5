import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 876 = cert_data/n13/h13c.vec.part0876, entries 84506836992 .. 84603305983, chunks 20148 .. 20170
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v876 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0876" 385875968 16777216

end CS31aData.N13
