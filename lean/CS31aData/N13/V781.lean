import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 781 = cert_data/n13/h13c.vec.part0781, entries 75342282752 .. 75438751743, chunks 17963 .. 17985
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v781 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0781" 385875968 16777216

end CS31aData.N13
