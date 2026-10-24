import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 415 = cert_data/n13/h13c.low.part0415, entries 53959720960 .. 54089744383, chunks 12865 .. 12895
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l415 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0415" 390070272 12582912

end CS31aData.N13
