import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 401 = cert_data/n13/h13c.vec.part0401, entries 38684065792 .. 38780534783, chunks 9223 .. 9245
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v401 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0401" 385875968 16777216

end CS31aData.N13
