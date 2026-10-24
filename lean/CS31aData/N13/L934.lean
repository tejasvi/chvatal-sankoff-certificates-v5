import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 934 = cert_data/n13/h13c.low.part0934, entries 121441878016 .. 121571901439, chunks 28954 .. 28984
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l934 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0934" 390070272 12582912

end CS31aData.N13
