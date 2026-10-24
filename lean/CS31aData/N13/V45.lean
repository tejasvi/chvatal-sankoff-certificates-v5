import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 45 = cert_data/n13/h13c.vec.part0045, entries 4341104640 .. 4437573631, chunks 1035 .. 1057
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v45 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0045" 385875968 16777216

end CS31aData.N13
