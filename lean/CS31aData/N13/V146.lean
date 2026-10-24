import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 146 = cert_data/n13/h13c.vec.part0146, entries 14084472832 .. 14180941823, chunks 3358 .. 3380
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v146 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0146" 385875968 16777216

end CS31aData.N13
