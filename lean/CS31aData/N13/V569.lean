import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 569 = cert_data/n13/h13c.vec.part0569, entries 54890856448 .. 54987325439, chunks 13087 .. 13109
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v569 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0569" 385875968 16777216

end CS31aData.N13
