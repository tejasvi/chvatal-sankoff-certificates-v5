import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 698 = cert_data/n13/h13c.vec.part0698, entries 67335356416 .. 67431825407, chunks 16054 .. 16076
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v698 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0698" 385875968 16777216

end CS31aData.N13
