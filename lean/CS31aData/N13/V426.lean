import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 426 = cert_data/n13/h13c.vec.part0426, entries 41095790592 .. 41192259583, chunks 9798 .. 9820
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v426 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0426" 385875968 16777216

end CS31aData.N13
