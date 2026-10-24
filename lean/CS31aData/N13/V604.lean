import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 604 = cert_data/n13/h13c.vec.part0604, entries 58267271168 .. 58363740159, chunks 13892 .. 13914
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v604 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0604" 385875968 16777216

end CS31aData.N13
