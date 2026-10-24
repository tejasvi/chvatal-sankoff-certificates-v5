import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 203 = cert_data/n13/h13c.vec.part0203, entries 19583205376 .. 19679674367, chunks 4669 .. 4691
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v203 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0203" 385875968 16777216

end CS31aData.N13
