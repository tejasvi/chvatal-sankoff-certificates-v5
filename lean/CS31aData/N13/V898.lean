import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 898 = cert_data/n13/h13c.vec.part0898, entries 86629154816 .. 86725623807, chunks 20654 .. 20676
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v898 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0898" 385875968 16777216

end CS31aData.N13
