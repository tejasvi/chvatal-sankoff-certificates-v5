import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1568 = cert_data/n13/h13c.vec.part1568, entries 151263379456 .. 151359848447, chunks 36064 .. 36086
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1568 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1568" 385875968 16777216

end CS31aData.N13
