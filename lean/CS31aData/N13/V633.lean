import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 633 = cert_data/n13/h13c.vec.part0633, entries 61064871936 .. 61161340927, chunks 14559 .. 14581
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v633 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0633" 385875968 16777216

end CS31aData.N13
