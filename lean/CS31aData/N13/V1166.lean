import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1166 = cert_data/n13/h13c.vec.part1166, entries 112482844672 .. 112579313663, chunks 26818 .. 26840
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1166 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1166" 385875968 16777216

end CS31aData.N13
