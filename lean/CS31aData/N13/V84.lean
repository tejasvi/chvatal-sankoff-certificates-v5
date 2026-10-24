import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 84 = cert_data/n13/h13c.vec.part0084, entries 8103395328 .. 8199864319, chunks 1932 .. 1954
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v84 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0084" 385875968 16777216

end CS31aData.N13
