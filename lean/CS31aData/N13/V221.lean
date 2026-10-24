import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 221 = cert_data/n13/h13c.vec.part0221, entries 21319647232 .. 21416116223, chunks 5083 .. 5105
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v221 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0221" 385875968 16777216

end CS31aData.N13
