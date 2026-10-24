import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 513 = cert_data/n13/h13c.vec.part0513, entries 49488592896 .. 49585061887, chunks 11799 .. 11821
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v513 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0513" 385875968 16777216

end CS31aData.N13
