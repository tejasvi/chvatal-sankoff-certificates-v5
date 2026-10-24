import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 980 = cert_data/n13/h13c.vec.part0980, entries 94539612160 .. 94636081151, chunks 22540 .. 22562
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v980 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0980" 385875968 16777216

end CS31aData.N13
