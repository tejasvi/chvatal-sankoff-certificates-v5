import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 424 = cert_data/n13/h13c.vec.part0424, entries 40902852608 .. 40999321599, chunks 9752 .. 9774
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v424 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0424" 385875968 16777216

end CS31aData.N13
