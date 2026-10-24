import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1296 = cert_data/n13/h13c.vec.part1296, entries 125023813632 .. 125120282623, chunks 29808 .. 29830
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1296 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1296" 385875968 16777216

end CS31aData.N13
