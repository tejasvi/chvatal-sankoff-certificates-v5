import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1459 = cert_data/n13/h13c.vec.part1459, entries 140748259328 .. 140844728319, chunks 33557 .. 33579
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1459 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1459" 385875968 16777216

end CS31aData.N13
