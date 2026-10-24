import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1018 = cert_data/n13/h13c.vec.part1018, entries 98205433856 .. 98301902847, chunks 23414 .. 23436
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1018 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1018" 385875968 16777216

end CS31aData.N13
