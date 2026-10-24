import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 935 = cert_data/n13/h13c.vec.part0935, entries 90198507520 .. 90294976511, chunks 21505 .. 21527
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v935 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0935" 385875968 16777216

end CS31aData.N13
