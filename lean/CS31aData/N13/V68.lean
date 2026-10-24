import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 68 = cert_data/n13/h13c.vec.part0068, entries 6559891456 .. 6656360447, chunks 1564 .. 1586
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v68 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0068" 385875968 16777216

end CS31aData.N13
