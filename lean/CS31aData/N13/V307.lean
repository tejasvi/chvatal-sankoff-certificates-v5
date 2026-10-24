import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 307 = cert_data/n13/h13c.vec.part0307, entries 29615980544 .. 29712449535, chunks 7061 .. 7083
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v307 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0307" 385875968 16777216

end CS31aData.N13
