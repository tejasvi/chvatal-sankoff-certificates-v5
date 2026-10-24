import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 867 = cert_data/n13/h13c.vec.part0867, entries 83638616064 .. 83735085055, chunks 19941 .. 19963
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v867 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0867" 385875968 16777216

end CS31aData.N13
