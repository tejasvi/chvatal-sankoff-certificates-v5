import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1028 = cert_data/n13/h13c.vec.part1028, entries 99170123776 .. 99266592767, chunks 23644 .. 23666
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1028 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1028" 385875968 16777216

end CS31aData.N13
