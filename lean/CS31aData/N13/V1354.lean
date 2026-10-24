import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1354 = cert_data/n13/h13c.vec.part1354, entries 130619015168 .. 130715484159, chunks 31142 .. 31164
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1354 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1354" 385875968 16777216

end CS31aData.N13
