import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 382 = cert_data/n13/h13c.vec.part0382, entries 36851154944 .. 36947623935, chunks 8786 .. 8808
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v382 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0382" 385875968 16777216

end CS31aData.N13
