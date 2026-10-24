import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1257 = cert_data/n13/h13c.vec.part1257, entries 121261522944 .. 121357991935, chunks 28911 .. 28933
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1257 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1257" 385875968 16777216

end CS31aData.N13
