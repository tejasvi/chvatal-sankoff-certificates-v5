import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 184 = cert_data/n13/h13c.low.part0184, entries 23924310016 .. 24054333439, chunks 5704 .. 5734
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l184 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0184" 390070272 12582912

end CS31aData.N13
