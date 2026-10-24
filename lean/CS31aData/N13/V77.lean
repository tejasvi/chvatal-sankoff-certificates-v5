import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 77 = cert_data/n13/h13c.vec.part0077, entries 7428112384 .. 7524581375, chunks 1771 .. 1793
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v77 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0077" 385875968 16777216

end CS31aData.N13
