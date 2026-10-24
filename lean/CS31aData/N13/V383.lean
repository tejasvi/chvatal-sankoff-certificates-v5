import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 383 = cert_data/n13/h13c.vec.part0383, entries 36947623936 .. 37044092927, chunks 8809 .. 8831
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v383 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0383" 385875968 16777216

end CS31aData.N13
