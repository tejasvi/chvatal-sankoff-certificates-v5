import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 546 = cert_data/n13/h13c.vec.part0546, entries 52672069632 .. 52768538623, chunks 12558 .. 12580
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v546 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0546" 385875968 16777216

end CS31aData.N13
