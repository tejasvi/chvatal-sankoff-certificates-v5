import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 975 = cert_data/n13/h13c.vec.part0975, entries 94057267200 .. 94153736191, chunks 22425 .. 22447
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v975 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0975" 385875968 16777216

end CS31aData.N13
