import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 224 = cert_data/n13/h13c.vec.part0224, entries 21609054208 .. 21705523199, chunks 5152 .. 5174
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v224 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0224" 385875968 16777216

end CS31aData.N13
