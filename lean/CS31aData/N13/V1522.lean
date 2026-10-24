import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1522 = cert_data/n13/h13c.vec.part1522, entries 146825805824 .. 146922274815, chunks 35006 .. 35028
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1522 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1522" 385875968 16777216

end CS31aData.N13
