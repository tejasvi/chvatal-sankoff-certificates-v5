import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 196 = cert_data/n13/h13c.vec.part0196, entries 18907922432 .. 19004391423, chunks 4508 .. 4530
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v196 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0196" 385875968 16777216

end CS31aData.N13
