import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 183 = cert_data/n13/h13c.vec.part0183, entries 17653825536 .. 17750294527, chunks 4209 .. 4231
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v183 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0183" 385875968 16777216

end CS31aData.N13
