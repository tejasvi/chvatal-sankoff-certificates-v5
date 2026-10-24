import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 773 = cert_data/n13/h13c.low.part0773, entries 100508106752 .. 100638130175, chunks 23963 .. 23993
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l773 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0773" 390070272 12582912

end CS31aData.N13
