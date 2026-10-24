import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 36 = cert_data/n13/h13c.vec.part0036, entries 3472883712 .. 3569352703, chunks 828 .. 850
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v36 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0036" 385875968 16777216

end CS31aData.N13
