import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1235 = cert_data/n13/h13c.vec.part1235, entries 119139205120 .. 119235674111, chunks 28405 .. 28427
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1235 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1235" 385875968 16777216

end CS31aData.N13
