import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 581 = cert_data/n13/h13c.vec.part0581, entries 56048484352 .. 56144953343, chunks 13363 .. 13385
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v581 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0581" 385875968 16777216

end CS31aData.N13
