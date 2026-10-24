import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 833 = cert_data/n13/h13c.vec.part0833, entries 80358670336 .. 80455139327, chunks 19159 .. 19181
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v833 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0833" 385875968 16777216

end CS31aData.N13
