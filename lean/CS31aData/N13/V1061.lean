import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1061 = cert_data/n13/h13c.vec.part1061, entries 102353600512 .. 102450069503, chunks 24403 .. 24425
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1061 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1061" 385875968 16777216

end CS31aData.N13
