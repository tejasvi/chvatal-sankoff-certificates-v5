import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 100 = cert_data/n13/h13c.vec.part0100, entries 9646899200 .. 9743368191, chunks 2300 .. 2322
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v100 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0100" 385875968 16777216

end CS31aData.N13
