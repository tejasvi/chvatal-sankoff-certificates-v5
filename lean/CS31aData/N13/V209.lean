import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 209 = cert_data/n13/h13c.vec.part0209, entries 20162019328 .. 20258488319, chunks 4807 .. 4829
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v209 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0209" 385875968 16777216

end CS31aData.N13
