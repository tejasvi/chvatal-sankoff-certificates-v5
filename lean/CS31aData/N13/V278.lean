import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 278 = cert_data/n13/h13c.vec.part0278, entries 26818379776 .. 26914848767, chunks 6394 .. 6416
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v278 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0278" 385875968 16777216

end CS31aData.N13
