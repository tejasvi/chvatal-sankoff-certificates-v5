import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 182 = cert_data/n13/h13c.vec.part0182, entries 17557356544 .. 17653825535, chunks 4186 .. 4208
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v182 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0182" 385875968 16777216

end CS31aData.N13
