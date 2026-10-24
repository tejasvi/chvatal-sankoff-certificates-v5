import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 350 = cert_data/n13/h13c.low.part0350, entries 45508198400 .. 45638221823, chunks 10850 .. 10880
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l350 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0350" 390070272 12582912

end CS31aData.N13
