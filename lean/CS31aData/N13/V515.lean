import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 515 = cert_data/n13/h13c.vec.part0515, entries 49681530880 .. 49777999871, chunks 11845 .. 11867
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v515 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0515" 385875968 16777216

end CS31aData.N13
