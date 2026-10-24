import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 757 = cert_data/n13/h13c.vec.part0757, entries 73027026944 .. 73123495935, chunks 17411 .. 17433
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v757 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0757" 385875968 16777216

end CS31aData.N13
