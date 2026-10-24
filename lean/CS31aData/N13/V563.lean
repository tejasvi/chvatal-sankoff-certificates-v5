import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 563 = cert_data/n13/h13c.vec.part0563, entries 54312042496 .. 54408511487, chunks 12949 .. 12971
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v563 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0563" 385875968 16777216

end CS31aData.N13
