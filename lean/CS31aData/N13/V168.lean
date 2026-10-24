import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 168 = cert_data/n13/h13c.vec.part0168, entries 16206790656 .. 16303259647, chunks 3864 .. 3886
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v168 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0168" 385875968 16777216

end CS31aData.N13
