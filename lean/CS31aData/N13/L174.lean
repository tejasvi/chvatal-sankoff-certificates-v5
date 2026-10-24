import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 174 = cert_data/n13/h13c.low.part0174, entries 22624075776 .. 22754099199, chunks 5394 .. 5424
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l174 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0174" 390070272 12582912

end CS31aData.N13
