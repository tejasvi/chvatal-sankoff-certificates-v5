import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 423 = cert_data/n13/h13c.vec.part0423, entries 40806383616 .. 40902852607, chunks 9729 .. 9751
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v423 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0423" 385875968 16777216

end CS31aData.N13
