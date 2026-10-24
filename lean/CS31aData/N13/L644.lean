import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 644 = cert_data/n13/h13c.low.part0644, entries 83735085056 .. 83865108479, chunks 19964 .. 19994
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l644 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0644" 390070272 12582912

end CS31aData.N13
