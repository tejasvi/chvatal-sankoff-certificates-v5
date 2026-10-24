import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 446 = cert_data/n13/h13c.vec.part0446, entries 43025170432 .. 43121639423, chunks 10258 .. 10280
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v446 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0446" 385875968 16777216

end CS31aData.N13
