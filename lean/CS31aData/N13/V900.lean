import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 900 = cert_data/n13/h13c.vec.part0900, entries 86822092800 .. 86918561791, chunks 20700 .. 20722
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v900 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0900" 385875968 16777216

end CS31aData.N13
