import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 184 = cert_data/n13/h13c.vec.part0184, entries 17750294528 .. 17846763519, chunks 4232 .. 4254
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v184 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0184" 385875968 16777216

end CS31aData.N13
