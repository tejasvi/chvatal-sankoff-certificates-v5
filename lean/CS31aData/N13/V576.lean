import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 576 = cert_data/n13/h13c.vec.part0576, entries 55566139392 .. 55662608383, chunks 13248 .. 13270
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v576 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0576" 385875968 16777216

end CS31aData.N13
