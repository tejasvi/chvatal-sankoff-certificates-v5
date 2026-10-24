import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 623 = cert_data/n13/h13c.vec.part0623, entries 60100182016 .. 60196651007, chunks 14329 .. 14351
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v623 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0623" 385875968 16777216

end CS31aData.N13
