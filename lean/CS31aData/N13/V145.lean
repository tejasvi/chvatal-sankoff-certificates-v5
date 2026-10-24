import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 145 = cert_data/n13/h13c.vec.part0145, entries 13988003840 .. 14084472831, chunks 3335 .. 3357
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v145 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0145" 385875968 16777216

end CS31aData.N13
