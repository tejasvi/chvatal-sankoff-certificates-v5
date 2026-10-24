import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1174 = cert_data/n13/h13c.low.part1174, entries 152647499776 .. 152777523199, chunks 36394 .. 36424
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1174 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1174" 390070272 12582912

end CS31aData.N13
