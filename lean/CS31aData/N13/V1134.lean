import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1134 = cert_data/n13/h13c.vec.part1134, entries 109395836928 .. 109492305919, chunks 26082 .. 26104
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1134 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1134" 385875968 16777216

end CS31aData.N13
