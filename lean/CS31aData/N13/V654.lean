import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 654 = cert_data/n13/h13c.vec.part0654, entries 63090720768 .. 63187189759, chunks 15042 .. 15064
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v654 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0654" 385875968 16777216

end CS31aData.N13
