import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 723 = cert_data/n13/h13c.vec.part0723, entries 69747081216 .. 69843550207, chunks 16629 .. 16651
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v723 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0723" 385875968 16777216

end CS31aData.N13
