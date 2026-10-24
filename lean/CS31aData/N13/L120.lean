import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 120 = cert_data/n13/h13c.low.part0120, entries 15602810880 .. 15732834303, chunks 3720 .. 3750
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l120 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0120" 390070272 12582912

end CS31aData.N13
