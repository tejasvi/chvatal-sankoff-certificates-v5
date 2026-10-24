import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 702 = cert_data/n13/h13c.vec.part0702, entries 67721232384 .. 67817701375, chunks 16146 .. 16168
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v702 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0702" 385875968 16777216

end CS31aData.N13
