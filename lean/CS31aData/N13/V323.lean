import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 323 = cert_data/n13/h13c.vec.part0323, entries 31159484416 .. 31255953407, chunks 7429 .. 7451
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v323 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0323" 385875968 16777216

end CS31aData.N13
