import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1711 = cert_data/n13/h13c.vec.part1711, entries 165058445312 .. 165154914303, chunks 39353 .. 39375
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1711 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1711" 385875968 16777216

end CS31aData.N13
