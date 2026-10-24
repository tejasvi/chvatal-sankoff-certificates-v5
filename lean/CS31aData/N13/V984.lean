import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 984 = cert_data/n13/h13c.vec.part0984, entries 94925488128 .. 95021957119, chunks 22632 .. 22654
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v984 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0984" 385875968 16777216

end CS31aData.N13
