import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 336 = cert_data/n13/h13c.vec.part0336, entries 32413581312 .. 32510050303, chunks 7728 .. 7750
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v336 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0336" 385875968 16777216

end CS31aData.N13
