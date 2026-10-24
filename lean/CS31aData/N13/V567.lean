import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 567 = cert_data/n13/h13c.vec.part0567, entries 54697918464 .. 54794387455, chunks 13041 .. 13063
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v567 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0567" 385875968 16777216

end CS31aData.N13
