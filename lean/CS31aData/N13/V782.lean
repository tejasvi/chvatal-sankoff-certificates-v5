import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 782 = cert_data/n13/h13c.vec.part0782, entries 75438751744 .. 75535220735, chunks 17986 .. 18008
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v782 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0782" 385875968 16777216

end CS31aData.N13
