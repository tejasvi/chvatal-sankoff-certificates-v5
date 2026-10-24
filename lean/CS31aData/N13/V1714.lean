import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1714 = cert_data/n13/h13c.vec.part1714, entries 165347852288 .. 165444321279, chunks 39422 .. 39444
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1714 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1714" 385875968 16777216

end CS31aData.N13
