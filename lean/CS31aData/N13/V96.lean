import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 96 = cert_data/n13/h13c.vec.part0096, entries 9261023232 .. 9357492223, chunks 2208 .. 2230
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v96 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0096" 385875968 16777216

end CS31aData.N13
