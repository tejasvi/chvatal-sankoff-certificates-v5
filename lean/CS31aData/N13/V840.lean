import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 840 = cert_data/n13/h13c.vec.part0840, entries 81033953280 .. 81130422271, chunks 19320 .. 19342
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v840 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0840" 385875968 16777216

end CS31aData.N13
