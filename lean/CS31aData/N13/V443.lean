import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 443 = cert_data/n13/h13c.vec.part0443, entries 42735763456 .. 42832232447, chunks 10189 .. 10211
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v443 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0443" 385875968 16777216

end CS31aData.N13
