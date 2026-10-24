import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1009 = cert_data/n13/h13c.vec.part1009, entries 97337212928 .. 97433681919, chunks 23207 .. 23229
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1009 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1009" 385875968 16777216

end CS31aData.N13
