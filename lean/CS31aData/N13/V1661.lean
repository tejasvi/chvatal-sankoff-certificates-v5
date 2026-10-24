import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1661 = cert_data/n13/h13c.vec.part1661, entries 160234995712 .. 160331464703, chunks 38203 .. 38225
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1661 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1661" 385875968 16777216

end CS31aData.N13
