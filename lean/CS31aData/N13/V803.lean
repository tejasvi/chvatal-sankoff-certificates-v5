import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 803 = cert_data/n13/h13c.vec.part0803, entries 77464600576 .. 77561069567, chunks 18469 .. 18491
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v803 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0803" 385875968 16777216

end CS31aData.N13
