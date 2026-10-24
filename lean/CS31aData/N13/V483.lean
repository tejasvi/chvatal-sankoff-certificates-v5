import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 483 = cert_data/n13/h13c.vec.part0483, entries 46594523136 .. 46690992127, chunks 11109 .. 11131
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v483 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0483" 385875968 16777216

end CS31aData.N13
