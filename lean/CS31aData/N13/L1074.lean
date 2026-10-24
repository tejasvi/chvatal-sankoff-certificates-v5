import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1074 = cert_data/n13/h13c.low.part1074, entries 139645157376 .. 139775180799, chunks 33294 .. 33324
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1074 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1074" 390070272 12582912

end CS31aData.N13
