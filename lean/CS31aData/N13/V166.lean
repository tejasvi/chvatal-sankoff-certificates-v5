import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 166 = cert_data/n13/h13c.vec.part0166, entries 16013852672 .. 16110321663, chunks 3818 .. 3840
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v166 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0166" 385875968 16777216

end CS31aData.N13
