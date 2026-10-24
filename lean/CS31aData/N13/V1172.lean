import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1172 = cert_data/n13/h13c.vec.part1172, entries 113061658624 .. 113158127615, chunks 26956 .. 26978
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1172 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1172" 385875968 16777216

end CS31aData.N13
