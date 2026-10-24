import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 848 = cert_data/n13/h13c.vec.part0848, entries 81805705216 .. 81902174207, chunks 19504 .. 19526
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v848 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0848" 385875968 16777216

end CS31aData.N13
