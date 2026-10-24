import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 248 = cert_data/n13/h13c.vec.part0248, entries 23924310016 .. 24020779007, chunks 5704 .. 5726
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v248 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0248" 385875968 16777216

end CS31aData.N13
