import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 381 = cert_data/n13/h13c.vec.part0381, entries 36754685952 .. 36851154943, chunks 8763 .. 8785
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v381 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0381" 385875968 16777216

end CS31aData.N13
