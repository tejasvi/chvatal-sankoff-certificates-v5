import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 851 = cert_data/n13/h13c.low.part0851, entries 110649933824 .. 110779957247, chunks 26381 .. 26411
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l851 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0851" 390070272 12582912

end CS31aData.N13
