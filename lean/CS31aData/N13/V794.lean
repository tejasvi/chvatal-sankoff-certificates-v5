import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 794 = cert_data/n13/h13c.vec.part0794, entries 76596379648 .. 76692848639, chunks 18262 .. 18284
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v794 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0794" 385875968 16777216

end CS31aData.N13
