import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1356 = cert_data/n13/h13c.vec.part1356, entries 130811953152 .. 130908422143, chunks 31188 .. 31210
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1356 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1356" 385875968 16777216

end CS31aData.N13
