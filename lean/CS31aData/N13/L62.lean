import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 62 = cert_data/n13/h13c.low.part0062, entries 8061452288 .. 8191475711, chunks 1922 .. 1952
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l62 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0062" 390070272 12582912

end CS31aData.N13
