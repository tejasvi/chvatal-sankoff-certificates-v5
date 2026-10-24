import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 66 = cert_data/n13/h13c.vec.part0066, entries 6366953472 .. 6463422463, chunks 1518 .. 1540
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v66 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0066" 385875968 16777216

end CS31aData.N13
