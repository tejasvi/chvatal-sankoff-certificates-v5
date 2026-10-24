import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 746 = cert_data/n13/h13c.low.part0746, entries 96997474304 .. 97127497727, chunks 23126 .. 23156
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l746 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0746" 390070272 12582912

end CS31aData.N13
