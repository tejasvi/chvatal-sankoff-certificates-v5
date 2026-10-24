import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 616 = cert_data/n13/h13c.vec.part0616, entries 59424899072 .. 59521368063, chunks 14168 .. 14190
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v616 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0616" 385875968 16777216

end CS31aData.N13
