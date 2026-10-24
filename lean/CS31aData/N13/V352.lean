import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 352 = cert_data/n13/h13c.vec.part0352, entries 33957085184 .. 34053554175, chunks 8096 .. 8118
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v352 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0352" 385875968 16777216

end CS31aData.N13
