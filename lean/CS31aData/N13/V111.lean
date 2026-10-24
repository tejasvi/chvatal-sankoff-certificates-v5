import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 111 = cert_data/n13/h13c.vec.part0111, entries 10708058112 .. 10804527103, chunks 2553 .. 2575
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v111 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0111" 385875968 16777216

end CS31aData.N13
