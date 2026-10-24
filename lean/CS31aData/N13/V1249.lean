import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1249 = cert_data/n13/h13c.vec.part1249, entries 120489771008 .. 120586239999, chunks 28727 .. 28749
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1249 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1249" 385875968 16777216

end CS31aData.N13
