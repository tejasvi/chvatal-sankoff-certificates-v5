import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 498 = cert_data/n13/h13c.vec.part0498, entries 48041558016 .. 48138027007, chunks 11454 .. 11476
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v498 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0498" 385875968 16777216

end CS31aData.N13
