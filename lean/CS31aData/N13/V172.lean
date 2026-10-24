import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 172 = cert_data/n13/h13c.vec.part0172, entries 16592666624 .. 16689135615, chunks 3956 .. 3978
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v172 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0172" 385875968 16777216

end CS31aData.N13
