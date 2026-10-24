import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 959 = cert_data/n13/h13c.low.part0959, entries 124692463616 .. 124822487039, chunks 29729 .. 29759
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l959 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0959" 390070272 12582912

end CS31aData.N13
