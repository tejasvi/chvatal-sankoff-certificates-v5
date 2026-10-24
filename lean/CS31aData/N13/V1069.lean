import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1069 = cert_data/n13/h13c.vec.part1069, entries 103125352448 .. 103221821439, chunks 24587 .. 24609
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1069 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1069" 385875968 16777216

end CS31aData.N13
