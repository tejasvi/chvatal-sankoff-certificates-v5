import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 502 = cert_data/n13/h13c.vec.part0502, entries 48427433984 .. 48523902975, chunks 11546 .. 11568
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v502 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0502" 385875968 16777216

end CS31aData.N13
