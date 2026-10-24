import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1286 = cert_data/n13/h13c.vec.part1286, entries 124059123712 .. 124155592703, chunks 29578 .. 29600
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1286 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1286" 385875968 16777216

end CS31aData.N13
