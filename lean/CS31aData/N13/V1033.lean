import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1033 = cert_data/n13/h13c.vec.part1033, entries 99652468736 .. 99748937727, chunks 23759 .. 23781
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1033 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1033" 385875968 16777216

end CS31aData.N13
