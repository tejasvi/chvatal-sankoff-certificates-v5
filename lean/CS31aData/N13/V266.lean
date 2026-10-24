import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 266 = cert_data/n13/h13c.vec.part0266, entries 25660751872 .. 25757220863, chunks 6118 .. 6140
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v266 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0266" 385875968 16777216

end CS31aData.N13
