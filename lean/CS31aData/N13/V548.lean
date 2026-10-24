import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 548 = cert_data/n13/h13c.vec.part0548, entries 52865007616 .. 52961476607, chunks 12604 .. 12626
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v548 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0548" 385875968 16777216

end CS31aData.N13
