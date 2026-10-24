import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 860 = cert_data/n13/h13c.vec.part0860, entries 82963333120 .. 83059802111, chunks 19780 .. 19802
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v860 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0860" 385875968 16777216

end CS31aData.N13
