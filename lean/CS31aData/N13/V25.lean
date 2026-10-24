import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 25 = cert_data/n13/h13c.vec.part0025, entries 2411724800 .. 2508193791, chunks 575 .. 597
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v25 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0025" 385875968 16777216

end CS31aData.N13
