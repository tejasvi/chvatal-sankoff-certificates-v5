import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1008 = cert_data/n13/h13c.vec.part1008, entries 97240743936 .. 97337212927, chunks 23184 .. 23206
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1008 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1008" 385875968 16777216

end CS31aData.N13
