import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 888 = cert_data/n13/h13c.low.part0888, entries 115460800512 .. 115590823935, chunks 27528 .. 27558
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l888 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0888" 390070272 12582912

end CS31aData.N13
