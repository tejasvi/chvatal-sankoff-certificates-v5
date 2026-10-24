import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 870 = cert_data/n13/h13c.vec.part0870, entries 83928023040 .. 84024492031, chunks 20010 .. 20032
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v870 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0870" 385875968 16777216

end CS31aData.N13
