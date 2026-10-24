import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 814 = cert_data/n13/h13c.vec.part0814, entries 78525759488 .. 78622228479, chunks 18722 .. 18744
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v814 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0814" 385875968 16777216

end CS31aData.N13
