import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 331 = cert_data/n13/h13c.vec.part0331, entries 31931236352 .. 32027705343, chunks 7613 .. 7635
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v331 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0331" 385875968 16777216

end CS31aData.N13
