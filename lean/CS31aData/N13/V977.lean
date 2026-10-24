import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 977 = cert_data/n13/h13c.vec.part0977, entries 94250205184 .. 94346674175, chunks 22471 .. 22493
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v977 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0977" 385875968 16777216

end CS31aData.N13
