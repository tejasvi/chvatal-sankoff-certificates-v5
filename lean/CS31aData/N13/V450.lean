import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 450 = cert_data/n13/h13c.vec.part0450, entries 43411046400 .. 43507515391, chunks 10350 .. 10372
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v450 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0450" 385875968 16777216

end CS31aData.N13
