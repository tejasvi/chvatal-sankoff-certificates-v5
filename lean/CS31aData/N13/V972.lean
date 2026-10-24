import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 972 = cert_data/n13/h13c.vec.part0972, entries 93767860224 .. 93864329215, chunks 22356 .. 22378
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v972 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0972" 385875968 16777216

end CS31aData.N13
