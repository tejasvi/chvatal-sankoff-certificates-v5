import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 944 = cert_data/n13/h13c.low.part0944, entries 122742112256 .. 122872135679, chunks 29264 .. 29294
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l944 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0944" 390070272 12582912

end CS31aData.N13
