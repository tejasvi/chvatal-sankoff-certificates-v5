import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 959 = cert_data/n13/h13c.vec.part0959, entries 92513763328 .. 92610232319, chunks 22057 .. 22079
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v959 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0959" 385875968 16777216

end CS31aData.N13
