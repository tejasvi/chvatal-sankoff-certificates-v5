import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 110 = cert_data/n13/h13c.vec.part0110, entries 10611589120 .. 10708058111, chunks 2530 .. 2552
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v110 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0110" 385875968 16777216

end CS31aData.N13
