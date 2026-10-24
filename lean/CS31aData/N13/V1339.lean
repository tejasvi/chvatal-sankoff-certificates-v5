import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1339 = cert_data/n13/h13c.vec.part1339, entries 129171980288 .. 129268449279, chunks 30797 .. 30819
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1339 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1339" 385875968 16777216

end CS31aData.N13
