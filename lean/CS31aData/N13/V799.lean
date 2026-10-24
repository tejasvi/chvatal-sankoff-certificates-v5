import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 799 = cert_data/n13/h13c.vec.part0799, entries 77078724608 .. 77175193599, chunks 18377 .. 18399
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v799 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0799" 385875968 16777216

end CS31aData.N13
