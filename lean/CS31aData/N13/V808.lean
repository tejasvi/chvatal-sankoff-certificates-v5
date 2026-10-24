import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 808 = cert_data/n13/h13c.vec.part0808, entries 77946945536 .. 78043414527, chunks 18584 .. 18606
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v808 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0808" 385875968 16777216

end CS31aData.N13
