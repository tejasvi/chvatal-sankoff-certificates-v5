import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 54 = cert_data/n13/h13c.vec.part0054, entries 5209325568 .. 5305794559, chunks 1242 .. 1264
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v54 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0054" 385875968 16777216

end CS31aData.N13
