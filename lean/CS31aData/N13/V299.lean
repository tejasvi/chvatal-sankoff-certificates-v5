import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 299 = cert_data/n13/h13c.vec.part0299, entries 28844228608 .. 28940697599, chunks 6877 .. 6899
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v299 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0299" 385875968 16777216

end CS31aData.N13
