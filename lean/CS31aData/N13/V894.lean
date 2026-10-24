import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 894 = cert_data/n13/h13c.vec.part0894, entries 86243278848 .. 86339747839, chunks 20562 .. 20584
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v894 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0894" 385875968 16777216

end CS31aData.N13
