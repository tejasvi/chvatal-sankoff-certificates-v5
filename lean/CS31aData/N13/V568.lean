import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 568 = cert_data/n13/h13c.vec.part0568, entries 54794387456 .. 54890856447, chunks 13064 .. 13086
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v568 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0568" 385875968 16777216

end CS31aData.N13
