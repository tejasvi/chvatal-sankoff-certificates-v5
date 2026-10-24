import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 778 = cert_data/n13/h13c.vec.part0778, entries 75052875776 .. 75149344767, chunks 17894 .. 17916
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v778 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0778" 385875968 16777216

end CS31aData.N13
