import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 795 = cert_data/n13/h13c.vec.part0795, entries 76692848640 .. 76789317631, chunks 18285 .. 18307
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v795 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0795" 385875968 16777216

end CS31aData.N13
