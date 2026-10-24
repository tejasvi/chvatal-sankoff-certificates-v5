import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 737 = cert_data/n13/h13c.vec.part0737, entries 71097647104 .. 71194116095, chunks 16951 .. 16973
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v737 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0737" 385875968 16777216

end CS31aData.N13
