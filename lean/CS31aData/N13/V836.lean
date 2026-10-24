import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 836 = cert_data/n13/h13c.vec.part0836, entries 80648077312 .. 80744546303, chunks 19228 .. 19250
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v836 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0836" 385875968 16777216

end CS31aData.N13
