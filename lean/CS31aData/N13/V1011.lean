import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1011 = cert_data/n13/h13c.vec.part1011, entries 97530150912 .. 97626619903, chunks 23253 .. 23275
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1011 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1011" 385875968 16777216

end CS31aData.N13
