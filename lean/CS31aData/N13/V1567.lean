import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1567 = cert_data/n13/h13c.vec.part1567, entries 151166910464 .. 151263379455, chunks 36041 .. 36063
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1567 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1567" 385875968 16777216

end CS31aData.N13
