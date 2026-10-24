import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 579 = cert_data/n13/h13c.vec.part0579, entries 55855546368 .. 55952015359, chunks 13317 .. 13339
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v579 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0579" 385875968 16777216

end CS31aData.N13
