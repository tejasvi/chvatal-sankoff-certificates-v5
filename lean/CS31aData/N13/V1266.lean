import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1266 = cert_data/n13/h13c.vec.part1266, entries 122129743872 .. 122226212863, chunks 29118 .. 29140
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1266 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1266" 385875968 16777216

end CS31aData.N13
