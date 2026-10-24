import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 144 = cert_data/n13/h13c.low.part0144, entries 18723373056 .. 18853396479, chunks 4464 .. 4494
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l144 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0144" 390070272 12582912

end CS31aData.N13
