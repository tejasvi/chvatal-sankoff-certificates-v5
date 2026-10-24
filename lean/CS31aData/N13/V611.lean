import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 611 = cert_data/n13/h13c.vec.part0611, entries 58942554112 .. 59039023103, chunks 14053 .. 14075
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v611 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0611" 385875968 16777216

end CS31aData.N13
