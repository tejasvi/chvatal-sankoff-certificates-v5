import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 461 = cert_data/n13/h13c.vec.part0461, entries 44472205312 .. 44568674303, chunks 10603 .. 10625
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v461 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0461" 385875968 16777216

end CS31aData.N13
