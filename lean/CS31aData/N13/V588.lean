import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 588 = cert_data/n13/h13c.vec.part0588, entries 56723767296 .. 56820236287, chunks 13524 .. 13546
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v588 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0588" 385875968 16777216

end CS31aData.N13
