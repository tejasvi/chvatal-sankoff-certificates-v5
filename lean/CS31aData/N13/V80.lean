import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 80 = cert_data/n13/h13c.vec.part0080, entries 7717519360 .. 7813988351, chunks 1840 .. 1862
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v80 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0080" 385875968 16777216

end CS31aData.N13
