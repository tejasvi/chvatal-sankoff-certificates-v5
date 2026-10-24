import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 933 = cert_data/n13/h13c.vec.part0933, entries 90005569536 .. 90102038527, chunks 21459 .. 21481
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v933 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0933" 385875968 16777216

end CS31aData.N13
