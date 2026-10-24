import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 976 = cert_data/n13/h13c.low.part0976, entries 126902861824 .. 127032885247, chunks 30256 .. 30286
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l976 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0976" 390070272 12582912

end CS31aData.N13
