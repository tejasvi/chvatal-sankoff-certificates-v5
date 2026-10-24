import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 389 = cert_data/n13/h13c.vec.part0389, entries 37526437888 .. 37622906879, chunks 8947 .. 8969
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v389 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0389" 385875968 16777216

end CS31aData.N13
