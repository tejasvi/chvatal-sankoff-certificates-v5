import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1447 = cert_data/n13/h13c.vec.part1447, entries 139590631424 .. 139687100415, chunks 33281 .. 33303
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1447 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1447" 385875968 16777216

end CS31aData.N13
