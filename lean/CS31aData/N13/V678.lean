import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 678 = cert_data/n13/h13c.vec.part0678, entries 65405976576 .. 65502445567, chunks 15594 .. 15616
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v678 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0678" 385875968 16777216

end CS31aData.N13
