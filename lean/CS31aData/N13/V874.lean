import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 874 = cert_data/n13/h13c.vec.part0874, entries 84313899008 .. 84410367999, chunks 20102 .. 20124
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v874 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0874" 385875968 16777216

end CS31aData.N13
