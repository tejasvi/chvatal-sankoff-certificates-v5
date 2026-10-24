import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1316 = cert_data/n13/h13c.vec.part1316, entries 126953193472 .. 127049662463, chunks 30268 .. 30290
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1316 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1316" 385875968 16777216

end CS31aData.N13
