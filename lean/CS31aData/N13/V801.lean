import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 801 = cert_data/n13/h13c.vec.part0801, entries 77271662592 .. 77368131583, chunks 18423 .. 18445
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v801 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0801" 385875968 16777216

end CS31aData.N13
