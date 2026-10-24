import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 432 = cert_data/n13/h13c.low.part0432, entries 56170119168 .. 56300142591, chunks 13392 .. 13422
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l432 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0432" 390070272 12582912

end CS31aData.N13
