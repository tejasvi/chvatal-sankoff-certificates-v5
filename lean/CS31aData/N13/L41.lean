import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 41 = cert_data/n13/h13c.low.part0041, entries 5330960384 .. 5460983807, chunks 1271 .. 1301
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l41 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0041" 390070272 12582912

end CS31aData.N13
