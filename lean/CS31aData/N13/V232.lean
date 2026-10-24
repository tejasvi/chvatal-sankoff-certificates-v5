import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 232 = cert_data/n13/h13c.vec.part0232, entries 22380806144 .. 22477275135, chunks 5336 .. 5358
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v232 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0232" 385875968 16777216

end CS31aData.N13
