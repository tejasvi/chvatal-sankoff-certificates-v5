import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 858 = cert_data/n13/h13c.vec.part0858, entries 82770395136 .. 82866864127, chunks 19734 .. 19756
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v858 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0858" 385875968 16777216

end CS31aData.N13
