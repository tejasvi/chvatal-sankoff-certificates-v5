import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 105 = cert_data/n13/h13c.vec.part0105, entries 10129244160 .. 10225713151, chunks 2415 .. 2437
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v105 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0105" 385875968 16777216

end CS31aData.N13
