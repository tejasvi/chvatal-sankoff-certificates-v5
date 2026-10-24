import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1182 = cert_data/n13/h13c.vec.part1182, entries 114026348544 .. 114122817535, chunks 27186 .. 27208
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1182 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1182" 385875968 16777216

end CS31aData.N13
