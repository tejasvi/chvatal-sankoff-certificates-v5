import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 879 = cert_data/n13/h13c.vec.part0879, entries 84796243968 .. 84892712959, chunks 20217 .. 20239
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v879 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0879" 385875968 16777216

end CS31aData.N13
