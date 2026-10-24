import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 983 = cert_data/n13/h13c.vec.part0983, entries 94829019136 .. 94925488127, chunks 22609 .. 22631
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v983 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0983" 385875968 16777216

end CS31aData.N13
