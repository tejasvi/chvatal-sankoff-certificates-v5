import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 885 = cert_data/n13/h13c.vec.part0885, entries 85375057920 .. 85471526911, chunks 20355 .. 20377
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v885 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0885" 385875968 16777216

end CS31aData.N13
