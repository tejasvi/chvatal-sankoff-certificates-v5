import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 684 = cert_data/n13/h13c.vec.part0684, entries 65984790528 .. 66081259519, chunks 15732 .. 15754
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v684 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0684" 385875968 16777216

end CS31aData.N13
