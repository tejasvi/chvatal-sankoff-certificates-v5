import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 804 = cert_data/n13/h13c.vec.part0804, entries 77561069568 .. 77657538559, chunks 18492 .. 18514
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v804 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0804" 385875968 16777216

end CS31aData.N13
