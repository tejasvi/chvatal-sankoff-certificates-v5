import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 259 = cert_data/n13/h13c.vec.part0259, entries 24985468928 .. 25081937919, chunks 5957 .. 5979
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v259 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0259" 385875968 16777216

end CS31aData.N13
