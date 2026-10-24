import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 231 = cert_data/n13/h13c.vec.part0231, entries 22284337152 .. 22380806143, chunks 5313 .. 5335
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v231 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0231" 385875968 16777216

end CS31aData.N13
