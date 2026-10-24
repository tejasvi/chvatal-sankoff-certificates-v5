import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 245 = cert_data/n13/h13c.vec.part0245, entries 23634903040 .. 23731372031, chunks 5635 .. 5657
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v245 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0245" 385875968 16777216

end CS31aData.N13
