import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 496 = cert_data/n13/h13c.vec.part0496, entries 47848620032 .. 47945089023, chunks 11408 .. 11430
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v496 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0496" 385875968 16777216

end CS31aData.N13
