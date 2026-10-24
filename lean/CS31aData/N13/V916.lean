import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 916 = cert_data/n13/h13c.vec.part0916, entries 88365596672 .. 88462065663, chunks 21068 .. 21090
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v916 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0916" 385875968 16777216

end CS31aData.N13
