import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1211 = cert_data/n13/h13c.vec.part1211, entries 116823949312 .. 116920418303, chunks 27853 .. 27875
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1211 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1211" 385875968 16777216

end CS31aData.N13
