import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1560 = cert_data/n13/h13c.vec.part1560, entries 150491627520 .. 150588096511, chunks 35880 .. 35902
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1560 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1560" 385875968 16777216

end CS31aData.N13
