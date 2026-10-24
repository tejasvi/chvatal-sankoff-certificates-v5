import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 222 = cert_data/n13/h13c.vec.part0222, entries 21416116224 .. 21512585215, chunks 5106 .. 5128
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v222 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0222" 385875968 16777216

end CS31aData.N13
