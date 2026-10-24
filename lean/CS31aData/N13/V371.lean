import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 371 = cert_data/n13/h13c.vec.part0371, entries 35789996032 .. 35886465023, chunks 8533 .. 8555
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v371 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0371" 385875968 16777216

end CS31aData.N13
