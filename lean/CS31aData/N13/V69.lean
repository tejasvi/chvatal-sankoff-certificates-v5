import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 69 = cert_data/n13/h13c.vec.part0069, entries 6656360448 .. 6752829439, chunks 1587 .. 1609
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v69 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0069" 385875968 16777216

end CS31aData.N13
