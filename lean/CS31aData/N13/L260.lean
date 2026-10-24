import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 260 = cert_data/n13/h13c.low.part0260, entries 33806090240 .. 33936113663, chunks 8060 .. 8090
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l260 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0260" 390070272 12582912

end CS31aData.N13
