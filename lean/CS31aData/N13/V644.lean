import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 644 = cert_data/n13/h13c.vec.part0644, entries 62126030848 .. 62222499839, chunks 14812 .. 14834
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v644 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0644" 385875968 16777216

end CS31aData.N13
