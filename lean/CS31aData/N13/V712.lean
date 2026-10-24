import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 712 = cert_data/n13/h13c.vec.part0712, entries 68685922304 .. 68782391295, chunks 16376 .. 16398
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v712 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0712" 385875968 16777216

end CS31aData.N13
