import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 555 = cert_data/n13/h13c.vec.part0555, entries 53540290560 .. 53636759551, chunks 12765 .. 12787
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v555 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0555" 385875968 16777216

end CS31aData.N13
