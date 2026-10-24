import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1618 = cert_data/n13/h13c.vec.part1618, entries 156086829056 .. 156183298047, chunks 37214 .. 37236
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1618 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1618" 385875968 16777216

end CS31aData.N13
