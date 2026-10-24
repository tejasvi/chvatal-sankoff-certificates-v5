import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 360 = cert_data/n13/h13c.low.part0360, entries 46808432640 .. 46938456063, chunks 11160 .. 11190
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l360 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0360" 390070272 12582912

end CS31aData.N13
