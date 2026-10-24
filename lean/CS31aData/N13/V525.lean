import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 525 = cert_data/n13/h13c.vec.part0525, entries 50646220800 .. 50742689791, chunks 12075 .. 12097
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v525 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0525" 385875968 16777216

end CS31aData.N13
