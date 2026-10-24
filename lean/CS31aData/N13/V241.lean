import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 241 = cert_data/n13/h13c.vec.part0241, entries 23249027072 .. 23345496063, chunks 5543 .. 5565
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v241 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0241" 385875968 16777216

end CS31aData.N13
