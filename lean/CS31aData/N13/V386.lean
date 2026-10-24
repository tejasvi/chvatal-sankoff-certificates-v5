import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 386 = cert_data/n13/h13c.vec.part0386, entries 37237030912 .. 37333499903, chunks 8878 .. 8900
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v386 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0386" 385875968 16777216

end CS31aData.N13
