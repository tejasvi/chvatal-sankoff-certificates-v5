import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 953 = cert_data/n13/h13c.vec.part0953, entries 91934949376 .. 92031418367, chunks 21919 .. 21941
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v953 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0953" 385875968 16777216

end CS31aData.N13
