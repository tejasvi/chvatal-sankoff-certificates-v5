import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 475 = cert_data/n13/h13c.vec.part0475, entries 45822771200 .. 45919240191, chunks 10925 .. 10947
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v475 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0475" 385875968 16777216

end CS31aData.N13
