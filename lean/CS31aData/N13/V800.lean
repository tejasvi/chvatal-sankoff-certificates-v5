import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 800 = cert_data/n13/h13c.vec.part0800, entries 77175193600 .. 77271662591, chunks 18400 .. 18422
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v800 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0800" 385875968 16777216

end CS31aData.N13
