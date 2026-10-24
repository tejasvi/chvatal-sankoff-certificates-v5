import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 857 = cert_data/n13/h13c.vec.part0857, entries 82673926144 .. 82770395135, chunks 19711 .. 19733
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v857 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0857" 385875968 16777216

end CS31aData.N13
