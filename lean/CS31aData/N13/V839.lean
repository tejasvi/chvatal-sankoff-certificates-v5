import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 839 = cert_data/n13/h13c.vec.part0839, entries 80937484288 .. 81033953279, chunks 19297 .. 19319
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v839 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0839" 385875968 16777216

end CS31aData.N13
