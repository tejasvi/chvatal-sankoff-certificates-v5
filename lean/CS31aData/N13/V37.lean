import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 37 = cert_data/n13/h13c.vec.part0037, entries 3569352704 .. 3665821695, chunks 851 .. 873
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v37 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0037" 385875968 16777216

end CS31aData.N13
