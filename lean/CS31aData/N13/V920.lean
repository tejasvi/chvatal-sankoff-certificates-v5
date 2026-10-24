import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 920 = cert_data/n13/h13c.vec.part0920, entries 88751472640 .. 88847941631, chunks 21160 .. 21182
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v920 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0920" 385875968 16777216

end CS31aData.N13
