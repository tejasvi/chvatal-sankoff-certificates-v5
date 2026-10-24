import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 699 = cert_data/n13/h13c.vec.part0699, entries 67431825408 .. 67528294399, chunks 16077 .. 16099
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v699 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0699" 385875968 16777216

end CS31aData.N13
