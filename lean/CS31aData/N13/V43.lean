import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 43 = cert_data/n13/h13c.vec.part0043, entries 4148166656 .. 4244635647, chunks 989 .. 1011
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v43 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0043" 385875968 16777216

end CS31aData.N13
