import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1340 = cert_data/n13/h13c.vec.part1340, entries 129268449280 .. 129364918271, chunks 30820 .. 30842
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1340 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1340" 385875968 16777216

end CS31aData.N13
