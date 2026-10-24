import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 123 = cert_data/n13/h13c.vec.part0123, entries 11865686016 .. 11962155007, chunks 2829 .. 2851
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v123 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0123" 385875968 16777216

end CS31aData.N13
