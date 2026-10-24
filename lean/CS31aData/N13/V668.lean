import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 668 = cert_data/n13/h13c.vec.part0668, entries 64441286656 .. 64537755647, chunks 15364 .. 15386
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v668 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0668" 385875968 16777216

end CS31aData.N13
