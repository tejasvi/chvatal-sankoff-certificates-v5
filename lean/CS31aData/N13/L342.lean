import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 342 = cert_data/n13/h13c.low.part0342, entries 44468011008 .. 44598034431, chunks 10602 .. 10632
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l342 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0342" 390070272 12582912

end CS31aData.N13
