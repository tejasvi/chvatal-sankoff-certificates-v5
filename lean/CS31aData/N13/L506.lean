import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 506 = cert_data/n13/h13c.low.part0506, entries 65791852544 .. 65921875967, chunks 15686 .. 15716
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l506 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0506" 390070272 12582912

end CS31aData.N13
