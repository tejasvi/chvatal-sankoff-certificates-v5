import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 280 = cert_data/n13/h13c.vec.part0280, entries 27011317760 .. 27107786751, chunks 6440 .. 6462
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v280 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0280" 385875968 16777216

end CS31aData.N13
