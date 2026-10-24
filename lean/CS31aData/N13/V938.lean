import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 938 = cert_data/n13/h13c.vec.part0938, entries 90487914496 .. 90584383487, chunks 21574 .. 21596
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v938 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0938" 385875968 16777216

end CS31aData.N13
