import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 31 = cert_data/n13/h13c.vec.part0031, entries 2990538752 .. 3087007743, chunks 713 .. 735
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v31 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0031" 385875968 16777216

end CS31aData.N13
