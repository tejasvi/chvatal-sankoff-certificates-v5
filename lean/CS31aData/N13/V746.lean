import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 746 = cert_data/n13/h13c.vec.part0746, entries 71965868032 .. 72062337023, chunks 17158 .. 17180
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v746 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0746" 385875968 16777216

end CS31aData.N13
