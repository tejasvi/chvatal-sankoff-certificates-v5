import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 748 = cert_data/n13/h13c.low.part0748, entries 97257521152 .. 97387544575, chunks 23188 .. 23218
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l748 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0748" 390070272 12582912

end CS31aData.N13
