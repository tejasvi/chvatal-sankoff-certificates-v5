import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 522 = cert_data/n13/h13c.low.part0522, entries 67872227328 .. 68002250751, chunks 16182 .. 16212
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l522 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0522" 390070272 12582912

end CS31aData.N13
