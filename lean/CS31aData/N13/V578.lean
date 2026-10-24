import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 578 = cert_data/n13/h13c.vec.part0578, entries 55759077376 .. 55855546367, chunks 13294 .. 13316
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v578 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0578" 385875968 16777216

end CS31aData.N13
