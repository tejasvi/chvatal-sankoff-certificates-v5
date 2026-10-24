import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1144 = cert_data/n13/h13c.vec.part1144, entries 110360526848 .. 110456995839, chunks 26312 .. 26334
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1144 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1144" 385875968 16777216

end CS31aData.N13
