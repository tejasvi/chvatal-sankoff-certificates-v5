import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 809 = cert_data/n13/h13c.low.part0809, entries 105188950016 .. 105318973439, chunks 25079 .. 25109
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l809 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0809" 390070272 12582912

end CS31aData.N13
