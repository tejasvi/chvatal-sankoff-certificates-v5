import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1353 = cert_data/n13/h13c.vec.part1353, entries 130522546176 .. 130619015167, chunks 31119 .. 31141
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1353 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1353" 385875968 16777216

end CS31aData.N13
