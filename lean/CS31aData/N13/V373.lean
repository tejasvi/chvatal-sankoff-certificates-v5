import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 373 = cert_data/n13/h13c.vec.part0373, entries 35982934016 .. 36079403007, chunks 8579 .. 8601
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v373 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0373" 385875968 16777216

end CS31aData.N13
