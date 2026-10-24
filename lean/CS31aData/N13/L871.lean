import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 871 = cert_data/n13/h13c.low.part0871, entries 113250402304 .. 113380425727, chunks 27001 .. 27031
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l871 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0871" 390070272 12582912

end CS31aData.N13
