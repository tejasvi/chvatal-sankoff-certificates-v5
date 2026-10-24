import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1091 = cert_data/n13/h13c.vec.part1091, entries 105247670272 .. 105344139263, chunks 25093 .. 25115
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1091 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1091" 385875968 16777216

end CS31aData.N13
