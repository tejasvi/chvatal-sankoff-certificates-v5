import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 322 = cert_data/n13/h13c.vec.part0322, entries 31063015424 .. 31159484415, chunks 7406 .. 7428
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v322 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0322" 385875968 16777216

end CS31aData.N13
