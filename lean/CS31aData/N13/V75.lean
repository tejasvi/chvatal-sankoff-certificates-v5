import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 75 = cert_data/n13/h13c.vec.part0075, entries 7235174400 .. 7331643391, chunks 1725 .. 1747
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v75 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0075" 385875968 16777216

end CS31aData.N13
