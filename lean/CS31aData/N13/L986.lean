import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 986 = cert_data/n13/h13c.low.part0986, entries 128203096064 .. 128333119487, chunks 30566 .. 30596
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l986 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0986" 390070272 12582912

end CS31aData.N13
