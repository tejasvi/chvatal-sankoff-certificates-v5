import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 693 = cert_data/n13/h13c.vec.part0693, entries 66853011456 .. 66949480447, chunks 15939 .. 15961
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v693 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0693" 385875968 16777216

end CS31aData.N13
