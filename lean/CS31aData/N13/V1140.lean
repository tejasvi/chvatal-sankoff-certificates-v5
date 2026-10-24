import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1140 = cert_data/n13/h13c.vec.part1140, entries 109974650880 .. 110071119871, chunks 26220 .. 26242
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1140 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1140" 385875968 16777216

end CS31aData.N13
