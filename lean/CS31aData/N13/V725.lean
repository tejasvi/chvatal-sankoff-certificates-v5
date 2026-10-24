import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 725 = cert_data/n13/h13c.vec.part0725, entries 69940019200 .. 70036488191, chunks 16675 .. 16697
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v725 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0725" 385875968 16777216

end CS31aData.N13
