import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 594 = cert_data/n13/h13c.vec.part0594, entries 57302581248 .. 57399050239, chunks 13662 .. 13684
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v594 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0594" 385875968 16777216

end CS31aData.N13
