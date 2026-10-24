import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 909 = cert_data/n13/h13c.vec.part0909, entries 87690313728 .. 87786782719, chunks 20907 .. 20929
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v909 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0909" 385875968 16777216

end CS31aData.N13
