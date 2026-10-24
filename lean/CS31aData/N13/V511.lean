import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 511 = cert_data/n13/h13c.vec.part0511, entries 49295654912 .. 49392123903, chunks 11753 .. 11775
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v511 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0511" 385875968 16777216

end CS31aData.N13
