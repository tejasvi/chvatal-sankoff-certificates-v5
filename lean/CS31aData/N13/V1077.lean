import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1077 = cert_data/n13/h13c.vec.part1077, entries 103897104384 .. 103993573375, chunks 24771 .. 24793
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1077 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1077" 385875968 16777216

end CS31aData.N13
