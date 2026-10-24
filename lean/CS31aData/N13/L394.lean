import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 394 = cert_data/n13/h13c.low.part0394, entries 51229229056 .. 51359252479, chunks 12214 .. 12244
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l394 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0394" 390070272 12582912

end CS31aData.N13
