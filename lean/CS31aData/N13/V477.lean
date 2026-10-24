import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 477 = cert_data/n13/h13c.vec.part0477, entries 46015709184 .. 46112178175, chunks 10971 .. 10993
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v477 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0477" 385875968 16777216

end CS31aData.N13
