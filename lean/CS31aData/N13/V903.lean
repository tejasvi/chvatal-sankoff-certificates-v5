import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 903 = cert_data/n13/h13c.vec.part0903, entries 87111499776 .. 87207968767, chunks 20769 .. 20791
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v903 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0903" 385875968 16777216

end CS31aData.N13
