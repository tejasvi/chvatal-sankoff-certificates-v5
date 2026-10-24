import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1369 = cert_data/n13/h13c.vec.part1369, entries 132066050048 .. 132162519039, chunks 31487 .. 31509
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1369 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1369" 385875968 16777216

end CS31aData.N13
