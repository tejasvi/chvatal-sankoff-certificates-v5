import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1164 = cert_data/n13/h13c.vec.part1164, entries 112289906688 .. 112386375679, chunks 26772 .. 26794
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1164 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1164" 385875968 16777216

end CS31aData.N13
