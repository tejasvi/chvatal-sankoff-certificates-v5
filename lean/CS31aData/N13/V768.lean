import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 768 = cert_data/n13/h13c.vec.part0768, entries 74088185856 .. 74184654847, chunks 17664 .. 17686
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v768 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0768" 385875968 16777216

end CS31aData.N13
