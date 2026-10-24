import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 20 = cert_data/n13/h13c.vec.part0020, entries 1929379840 .. 2025848831, chunks 460 .. 482
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v20 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0020" 385875968 16777216

end CS31aData.N13
