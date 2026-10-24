import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 902 = cert_data/n13/h13c.vec.part0902, entries 87015030784 .. 87111499775, chunks 20746 .. 20768
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v902 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0902" 385875968 16777216

end CS31aData.N13
