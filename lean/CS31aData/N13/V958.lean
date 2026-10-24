import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 958 = cert_data/n13/h13c.vec.part0958, entries 92417294336 .. 92513763327, chunks 22034 .. 22056
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v958 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0958" 385875968 16777216

end CS31aData.N13
