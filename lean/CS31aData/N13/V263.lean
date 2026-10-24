import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 263 = cert_data/n13/h13c.vec.part0263, entries 25371344896 .. 25467813887, chunks 6049 .. 6071
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v263 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0263" 385875968 16777216

end CS31aData.N13
