import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1173 = cert_data/n13/h13c.vec.part1173, entries 113158127616 .. 113254596607, chunks 26979 .. 27001
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1173 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1173" 385875968 16777216

end CS31aData.N13
