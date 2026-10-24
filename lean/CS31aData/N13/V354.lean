import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 354 = cert_data/n13/h13c.vec.part0354, entries 34150023168 .. 34246492159, chunks 8142 .. 8164
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v354 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0354" 385875968 16777216

end CS31aData.N13
