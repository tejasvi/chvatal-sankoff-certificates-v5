import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 206 = cert_data/n13/h13c.vec.part0206, entries 19872612352 .. 19969081343, chunks 4738 .. 4760
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v206 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0206" 385875968 16777216

end CS31aData.N13
