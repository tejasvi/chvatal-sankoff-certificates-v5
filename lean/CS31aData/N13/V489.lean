import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 489 = cert_data/n13/h13c.vec.part0489, entries 47173337088 .. 47269806079, chunks 11247 .. 11269
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v489 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0489" 385875968 16777216

end CS31aData.N13
