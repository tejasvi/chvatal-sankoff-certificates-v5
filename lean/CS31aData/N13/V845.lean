import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 845 = cert_data/n13/h13c.vec.part0845, entries 81516298240 .. 81612767231, chunks 19435 .. 19457
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v845 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0845" 385875968 16777216

end CS31aData.N13
