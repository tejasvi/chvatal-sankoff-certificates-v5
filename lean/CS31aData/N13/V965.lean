import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 965 = cert_data/n13/h13c.vec.part0965, entries 93092577280 .. 93189046271, chunks 22195 .. 22217
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v965 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0965" 385875968 16777216

end CS31aData.N13
