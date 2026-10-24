import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 38 = cert_data/n13/h13c.vec.part0038, entries 3665821696 .. 3762290687, chunks 874 .. 896
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v38 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0038" 385875968 16777216

end CS31aData.N13
