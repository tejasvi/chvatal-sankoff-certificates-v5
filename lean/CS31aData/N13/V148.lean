import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 148 = cert_data/n13/h13c.vec.part0148, entries 14277410816 .. 14373879807, chunks 3404 .. 3426
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v148 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0148" 385875968 16777216

end CS31aData.N13
