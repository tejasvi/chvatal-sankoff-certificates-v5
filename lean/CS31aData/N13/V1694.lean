import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1694 = cert_data/n13/h13c.vec.part1694, entries 163418472448 .. 163514941439, chunks 38962 .. 38984
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1694 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1694" 385875968 16777216

end CS31aData.N13
