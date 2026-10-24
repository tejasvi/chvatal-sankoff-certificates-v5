import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 897 = cert_data/n13/h13c.vec.part0897, entries 86532685824 .. 86629154815, chunks 20631 .. 20653
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v897 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0897" 385875968 16777216

end CS31aData.N13
