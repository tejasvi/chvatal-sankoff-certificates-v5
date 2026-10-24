import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 787 = cert_data/n13/h13c.vec.part0787, entries 75921096704 .. 76017565695, chunks 18101 .. 18123
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v787 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0787" 385875968 16777216

end CS31aData.N13
