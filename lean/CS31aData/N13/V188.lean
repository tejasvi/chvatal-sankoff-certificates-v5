import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 188 = cert_data/n13/h13c.vec.part0188, entries 18136170496 .. 18232639487, chunks 4324 .. 4346
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v188 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0188" 385875968 16777216

end CS31aData.N13
