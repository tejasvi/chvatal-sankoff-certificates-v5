import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 493 = cert_data/n13/h13c.vec.part0493, entries 47559213056 .. 47655682047, chunks 11339 .. 11361
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v493 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0493" 385875968 16777216

end CS31aData.N13
