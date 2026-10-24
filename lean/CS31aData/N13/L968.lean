import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 968 = cert_data/n13/h13c.low.part0968, entries 125862674432 .. 125992697855, chunks 30008 .. 30038
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l968 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0968" 390070272 12582912

end CS31aData.N13
