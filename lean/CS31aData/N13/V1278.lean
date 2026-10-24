import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1278 = cert_data/n13/h13c.vec.part1278, entries 123287371776 .. 123383840767, chunks 29394 .. 29416
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1278 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1278" 385875968 16777216

end CS31aData.N13
