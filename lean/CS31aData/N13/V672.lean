import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 672 = cert_data/n13/h13c.vec.part0672, entries 64827162624 .. 64923631615, chunks 15456 .. 15478
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v672 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0672" 385875968 16777216

end CS31aData.N13
