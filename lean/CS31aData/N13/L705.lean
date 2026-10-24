import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 705 = cert_data/n13/h13c.low.part0705, entries 91666513920 .. 91796537343, chunks 21855 .. 21885
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l705 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0705" 390070272 12582912

end CS31aData.N13
