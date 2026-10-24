import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 820 = cert_data/n13/h13c.vec.part0820, entries 79104573440 .. 79201042431, chunks 18860 .. 18882
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v820 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0820" 385875968 16777216

end CS31aData.N13
