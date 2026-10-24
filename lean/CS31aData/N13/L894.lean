import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 894 = cert_data/n13/h13c.low.part0894, entries 116240941056 .. 116370964479, chunks 27714 .. 27744
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l894 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0894" 390070272 12582912

end CS31aData.N13
