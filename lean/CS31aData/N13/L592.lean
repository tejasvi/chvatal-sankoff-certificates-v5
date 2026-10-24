import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 592 = cert_data/n13/h13c.low.part0592, entries 76973867008 .. 77103890431, chunks 18352 .. 18382
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l592 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0592" 390070272 12582912

end CS31aData.N13
