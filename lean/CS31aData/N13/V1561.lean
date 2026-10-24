import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1561 = cert_data/n13/h13c.vec.part1561, entries 150588096512 .. 150684565503, chunks 35903 .. 35925
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1561 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1561" 385875968 16777216

end CS31aData.N13
