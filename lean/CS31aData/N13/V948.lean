import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 948 = cert_data/n13/h13c.vec.part0948, entries 91452604416 .. 91549073407, chunks 21804 .. 21826
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v948 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0948" 385875968 16777216

end CS31aData.N13
