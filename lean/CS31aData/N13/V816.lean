import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 816 = cert_data/n13/h13c.vec.part0816, entries 78718697472 .. 78815166463, chunks 18768 .. 18790
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v816 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0816" 385875968 16777216

end CS31aData.N13
