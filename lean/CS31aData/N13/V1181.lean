import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1181 = cert_data/n13/h13c.vec.part1181, entries 113929879552 .. 114026348543, chunks 27163 .. 27185
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1181 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1181" 385875968 16777216

end CS31aData.N13
