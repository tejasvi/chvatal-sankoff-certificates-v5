import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 589 = cert_data/n13/h13c.vec.part0589, entries 56820236288 .. 56916705279, chunks 13547 .. 13569
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v589 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0589" 385875968 16777216

end CS31aData.N13
