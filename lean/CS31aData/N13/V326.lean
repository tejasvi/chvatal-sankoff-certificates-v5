import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 326 = cert_data/n13/h13c.vec.part0326, entries 31448891392 .. 31545360383, chunks 7498 .. 7520
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v326 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0326" 385875968 16777216

end CS31aData.N13
