import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1541 = cert_data/n13/h13c.vec.part1541, entries 148658716672 .. 148755185663, chunks 35443 .. 35465
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1541 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1541" 385875968 16777216

end CS31aData.N13
