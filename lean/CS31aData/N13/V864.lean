import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 864 = cert_data/n13/h13c.vec.part0864, entries 83349209088 .. 83445678079, chunks 19872 .. 19894
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v864 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0864" 385875968 16777216

end CS31aData.N13
