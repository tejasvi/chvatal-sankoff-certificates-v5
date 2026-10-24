import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 622 = cert_data/n13/h13c.vec.part0622, entries 60003713024 .. 60100182015, chunks 14306 .. 14328
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v622 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0622" 385875968 16777216

end CS31aData.N13
