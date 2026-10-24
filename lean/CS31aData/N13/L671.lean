import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 671 = cert_data/n13/h13c.low.part0671, entries 87245717504 .. 87375740927, chunks 20801 .. 20831
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l671 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0671" 390070272 12582912

end CS31aData.N13
