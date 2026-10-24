import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 220 = cert_data/n13/h13c.vec.part0220, entries 21223178240 .. 21319647231, chunks 5060 .. 5082
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v220 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0220" 385875968 16777216

end CS31aData.N13
