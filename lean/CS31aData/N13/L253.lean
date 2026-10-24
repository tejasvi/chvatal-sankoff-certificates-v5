import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 253 = cert_data/n13/h13c.low.part0253, entries 32895926272 .. 33025949695, chunks 7843 .. 7873
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l253 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0253" 390070272 12582912

end CS31aData.N13
