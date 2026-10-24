import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1056 = cert_data/n13/h13c.vec.part1056, entries 101871255552 .. 101967724543, chunks 24288 .. 24310
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1056 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1056" 385875968 16777216

end CS31aData.N13
