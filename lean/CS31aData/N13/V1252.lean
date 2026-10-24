import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1252 = cert_data/n13/h13c.vec.part1252, entries 120779177984 .. 120875646975, chunks 28796 .. 28818
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1252 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1252" 385875968 16777216

end CS31aData.N13
