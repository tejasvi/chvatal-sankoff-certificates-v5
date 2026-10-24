import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1220 = cert_data/n13/h13c.vec.part1220, entries 117692170240 .. 117788639231, chunks 28060 .. 28082
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1220 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1220" 385875968 16777216

end CS31aData.N13
