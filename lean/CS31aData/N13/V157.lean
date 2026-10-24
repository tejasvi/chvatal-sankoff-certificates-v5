import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 157 = cert_data/n13/h13c.vec.part0157, entries 15145631744 .. 15242100735, chunks 3611 .. 3633
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v157 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0157" 385875968 16777216

end CS31aData.N13
