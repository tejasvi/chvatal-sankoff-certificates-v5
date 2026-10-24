import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 357 = cert_data/n13/h13c.low.part0357, entries 46418362368 .. 46548385791, chunks 11067 .. 11097
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l357 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0357" 390070272 12582912

end CS31aData.N13
