import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1516 = cert_data/n13/h13c.vec.part1516, entries 146246991872 .. 146343460863, chunks 34868 .. 34890
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1516 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1516" 385875968 16777216

end CS31aData.N13
