import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 732 = cert_data/n13/h13c.low.part0732, entries 95177146368 .. 95307169791, chunks 22692 .. 22722
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l732 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0732" 390070272 12582912

end CS31aData.N13
