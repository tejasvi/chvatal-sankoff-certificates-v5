import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 765 = cert_data/n13/h13c.low.part0765, entries 99467919360 .. 99597942783, chunks 23715 .. 23745
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l765 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0765" 390070272 12582912

end CS31aData.N13
