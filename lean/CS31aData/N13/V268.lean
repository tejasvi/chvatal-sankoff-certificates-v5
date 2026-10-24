import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 268 = cert_data/n13/h13c.vec.part0268, entries 25853689856 .. 25950158847, chunks 6164 .. 6186
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v268 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0268" 385875968 16777216

end CS31aData.N13
