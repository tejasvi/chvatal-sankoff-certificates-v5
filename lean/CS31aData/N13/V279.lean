import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 279 = cert_data/n13/h13c.vec.part0279, entries 26914848768 .. 27011317759, chunks 6417 .. 6439
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v279 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0279" 385875968 16777216

end CS31aData.N13
