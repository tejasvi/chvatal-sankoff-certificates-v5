import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 342 = cert_data/n13/h13c.vec.part0342, entries 32992395264 .. 33088864255, chunks 7866 .. 7888
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v342 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0342" 385875968 16777216

end CS31aData.N13
