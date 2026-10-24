import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 976 = cert_data/n13/h13c.vec.part0976, entries 94153736192 .. 94250205183, chunks 22448 .. 22470
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v976 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0976" 385875968 16777216

end CS31aData.N13
