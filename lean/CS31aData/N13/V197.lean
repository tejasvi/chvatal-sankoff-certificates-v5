import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 197 = cert_data/n13/h13c.vec.part0197, entries 19004391424 .. 19100860415, chunks 4531 .. 4553
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v197 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0197" 385875968 16777216

end CS31aData.N13
