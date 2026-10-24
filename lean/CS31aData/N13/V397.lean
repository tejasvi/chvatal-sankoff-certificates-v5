import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 397 = cert_data/n13/h13c.vec.part0397, entries 38298189824 .. 38394658815, chunks 9131 .. 9153
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v397 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0397" 385875968 16777216

end CS31aData.N13
