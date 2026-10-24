import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1440 = cert_data/n13/h13c.vec.part1440, entries 138915348480 .. 139011817471, chunks 33120 .. 33142
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1440 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1440" 385875968 16777216

end CS31aData.N13
