import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 748 = cert_data/n13/h13c.vec.part0748, entries 72158806016 .. 72255275007, chunks 17204 .. 17226
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v748 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0748" 385875968 16777216

end CS31aData.N13
