import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 607 = cert_data/n13/h13c.low.part0607, entries 78924218368 .. 79054241791, chunks 18817 .. 18847
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l607 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0607" 390070272 12582912

end CS31aData.N13
