import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 647 = cert_data/n13/h13c.vec.part0647, entries 62415437824 .. 62511906815, chunks 14881 .. 14903
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v647 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0647" 385875968 16777216

end CS31aData.N13
