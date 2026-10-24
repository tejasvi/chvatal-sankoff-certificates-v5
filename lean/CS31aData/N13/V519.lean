import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 519 = cert_data/n13/h13c.vec.part0519, entries 50067406848 .. 50163875839, chunks 11937 .. 11959
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v519 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0519" 385875968 16777216

end CS31aData.N13
