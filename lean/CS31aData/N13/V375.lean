import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 375 = cert_data/n13/h13c.vec.part0375, entries 36175872000 .. 36272340991, chunks 8625 .. 8647
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v375 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0375" 385875968 16777216

end CS31aData.N13
