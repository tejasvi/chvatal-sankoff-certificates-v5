import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 365 = cert_data/n13/h13c.vec.part0365, entries 35211182080 .. 35307651071, chunks 8395 .. 8417
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v365 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0365" 385875968 16777216

end CS31aData.N13
