import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1256 = cert_data/n13/h13c.vec.part1256, entries 121165053952 .. 121261522943, chunks 28888 .. 28910
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1256 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1256" 385875968 16777216

end CS31aData.N13
