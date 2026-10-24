import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 818 = cert_data/n13/h13c.vec.part0818, entries 78911635456 .. 79008104447, chunks 18814 .. 18836
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v818 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0818" 385875968 16777216

end CS31aData.N13
