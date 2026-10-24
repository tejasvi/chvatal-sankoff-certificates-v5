import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 187 = cert_data/n13/h13c.vec.part0187, entries 18039701504 .. 18136170495, chunks 4301 .. 4323
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v187 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0187" 385875968 16777216

end CS31aData.N13
