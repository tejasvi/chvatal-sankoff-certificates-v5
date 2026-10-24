import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 129 = cert_data/n13/h13c.vec.part0129, entries 12444499968 .. 12540968959, chunks 2967 .. 2989
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v129 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0129" 385875968 16777216

end CS31aData.N13
