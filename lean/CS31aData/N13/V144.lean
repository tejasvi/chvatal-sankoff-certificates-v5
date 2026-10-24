import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 144 = cert_data/n13/h13c.vec.part0144, entries 13891534848 .. 13988003839, chunks 3312 .. 3334
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v144 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0144" 385875968 16777216

end CS31aData.N13
