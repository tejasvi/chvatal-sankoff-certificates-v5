import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 321 = cert_data/n13/h13c.vec.part0321, entries 30966546432 .. 31063015423, chunks 7383 .. 7405
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v321 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0321" 385875968 16777216

end CS31aData.N13
