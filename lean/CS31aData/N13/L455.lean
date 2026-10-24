import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 455 = cert_data/n13/h13c.low.part0455, entries 59160657920 .. 59290681343, chunks 14105 .. 14135
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l455 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0455" 390070272 12582912

end CS31aData.N13
