import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 169 = cert_data/n13/h13c.vec.part0169, entries 16303259648 .. 16399728639, chunks 3887 .. 3909
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v169 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0169" 385875968 16777216

end CS31aData.N13
