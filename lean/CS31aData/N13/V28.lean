import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 28 = cert_data/n13/h13c.vec.part0028, entries 2701131776 .. 2797600767, chunks 644 .. 666
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v28 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0028" 385875968 16777216

end CS31aData.N13
