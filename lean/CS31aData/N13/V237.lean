import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 237 = cert_data/n13/h13c.vec.part0237, entries 22863151104 .. 22959620095, chunks 5451 .. 5473
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v237 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0237" 385875968 16777216

end CS31aData.N13
