import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 429 = cert_data/n13/h13c.vec.part0429, entries 41385197568 .. 41481666559, chunks 9867 .. 9889
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v429 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0429" 385875968 16777216

end CS31aData.N13
