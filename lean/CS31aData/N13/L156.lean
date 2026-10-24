import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 156 = cert_data/n13/h13c.low.part0156, entries 20283654144 .. 20413677567, chunks 4836 .. 4866
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l156 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0156" 390070272 12582912

end CS31aData.N13
