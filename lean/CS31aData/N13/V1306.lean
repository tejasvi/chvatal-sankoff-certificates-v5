import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1306 = cert_data/n13/h13c.vec.part1306, entries 125988503552 .. 126084972543, chunks 30038 .. 30060
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1306 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1306" 385875968 16777216

end CS31aData.N13
