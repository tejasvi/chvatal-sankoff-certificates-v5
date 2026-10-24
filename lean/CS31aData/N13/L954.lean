import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 954 = cert_data/n13/h13c.low.part0954, entries 124042346496 .. 124172369919, chunks 29574 .. 29604
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l954 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0954" 390070272 12582912

end CS31aData.N13
