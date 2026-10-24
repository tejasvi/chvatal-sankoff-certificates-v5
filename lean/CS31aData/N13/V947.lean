import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 947 = cert_data/n13/h13c.vec.part0947, entries 91356135424 .. 91452604415, chunks 21781 .. 21803
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v947 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0947" 385875968 16777216

end CS31aData.N13
