import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 332 = cert_data/n13/h13c.vec.part0332, entries 32027705344 .. 32124174335, chunks 7636 .. 7658
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v332 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0332" 385875968 16777216

end CS31aData.N13
