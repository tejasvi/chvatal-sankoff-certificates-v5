import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 630 = cert_data/n13/h13c.vec.part0630, entries 60775464960 .. 60871933951, chunks 14490 .. 14512
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v630 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0630" 385875968 16777216

end CS31aData.N13
