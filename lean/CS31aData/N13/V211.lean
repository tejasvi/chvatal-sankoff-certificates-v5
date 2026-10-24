import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 211 = cert_data/n13/h13c.vec.part0211, entries 20354957312 .. 20451426303, chunks 4853 .. 4875
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v211 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0211" 385875968 16777216

end CS31aData.N13
