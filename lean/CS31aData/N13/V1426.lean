import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1426 = cert_data/n13/h13c.vec.part1426, entries 137564782592 .. 137661251583, chunks 32798 .. 32820
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1426 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1426" 385875968 16777216

end CS31aData.N13
