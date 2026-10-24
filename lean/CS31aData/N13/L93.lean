import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 93 = cert_data/n13/h13c.low.part0093, entries 12092178432 .. 12222201855, chunks 2883 .. 2913
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l93 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0093" 390070272 12582912

end CS31aData.N13
