import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 869 = cert_data/n13/h13c.vec.part0869, entries 83831554048 .. 83928023039, chunks 19987 .. 20009
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v869 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0869" 385875968 16777216

end CS31aData.N13
