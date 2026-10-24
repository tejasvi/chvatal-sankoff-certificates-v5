import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1294 = cert_data/n13/h13c.vec.part1294, entries 124830875648 .. 124927344639, chunks 29762 .. 29784
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1294 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1294" 385875968 16777216

end CS31aData.N13
