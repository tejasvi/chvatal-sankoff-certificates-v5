import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1539 = cert_data/n13/h13c.vec.part1539, entries 148465778688 .. 148562247679, chunks 35397 .. 35419
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1539 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1539" 385875968 16777216

end CS31aData.N13
