import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 344 = cert_data/n13/h13c.vec.part0344, entries 33185333248 .. 33281802239, chunks 7912 .. 7934
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v344 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0344" 385875968 16777216

end CS31aData.N13
