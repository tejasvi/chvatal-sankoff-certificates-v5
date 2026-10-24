import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1078 = cert_data/n13/h13c.vec.part1078, entries 103993573376 .. 104090042367, chunks 24794 .. 24816
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1078 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1078" 385875968 16777216

end CS31aData.N13
