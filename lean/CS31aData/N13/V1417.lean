import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1417 = cert_data/n13/h13c.vec.part1417, entries 136696561664 .. 136793030655, chunks 32591 .. 32613
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1417 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1417" 385875968 16777216

end CS31aData.N13
