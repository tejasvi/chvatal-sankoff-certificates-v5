import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 856 = cert_data/n13/h13c.vec.part0856, entries 82577457152 .. 82673926143, chunks 19688 .. 19710
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v856 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0856" 385875968 16777216

end CS31aData.N13
