import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 618 = cert_data/n13/h13c.low.part0618, entries 80354476032 .. 80484499455, chunks 19158 .. 19188
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l618 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0618" 390070272 12582912

end CS31aData.N13
