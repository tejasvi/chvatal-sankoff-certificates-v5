import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1515 = cert_data/n13/h13c.vec.part1515, entries 146150522880 .. 146246991871, chunks 34845 .. 34867
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1515 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1515" 385875968 16777216

end CS31aData.N13
