import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 69 = cert_data/n13/h13c.low.part0069, entries 8971616256 .. 9101639679, chunks 2139 .. 2169
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l69 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0069" 390070272 12582912

end CS31aData.N13
