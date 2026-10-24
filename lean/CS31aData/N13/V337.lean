import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 337 = cert_data/n13/h13c.vec.part0337, entries 32510050304 .. 32606519295, chunks 7751 .. 7773
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v337 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0337" 385875968 16777216

end CS31aData.N13
