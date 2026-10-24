import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 338 = cert_data/n13/h13c.vec.part0338, entries 32606519296 .. 32702988287, chunks 7774 .. 7796
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v338 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0338" 385875968 16777216

end CS31aData.N13
