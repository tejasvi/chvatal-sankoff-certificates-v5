import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 777 = cert_data/n13/h13c.vec.part0777, entries 74956406784 .. 75052875775, chunks 17871 .. 17893
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v777 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0777" 385875968 16777216

end CS31aData.N13
