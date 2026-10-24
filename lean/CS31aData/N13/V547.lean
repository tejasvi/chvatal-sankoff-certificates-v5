import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 547 = cert_data/n13/h13c.vec.part0547, entries 52768538624 .. 52865007615, chunks 12581 .. 12603
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v547 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0547" 385875968 16777216

end CS31aData.N13
