import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 774 = cert_data/n13/h13c.vec.part0774, entries 74666999808 .. 74763468799, chunks 17802 .. 17824
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v774 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0774" 385875968 16777216

end CS31aData.N13
