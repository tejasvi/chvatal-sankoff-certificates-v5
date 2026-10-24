import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 143 = cert_data/n13/h13c.vec.part0143, entries 13795065856 .. 13891534847, chunks 3289 .. 3311
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v143 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0143" 385875968 16777216

end CS31aData.N13
