import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 335 = cert_data/n13/h13c.low.part0335, entries 43557847040 .. 43687870463, chunks 10385 .. 10415
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l335 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0335" 390070272 12582912

end CS31aData.N13
