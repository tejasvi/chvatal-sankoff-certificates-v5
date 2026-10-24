import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 641 = cert_data/n13/h13c.vec.part0641, entries 61836623872 .. 61933092863, chunks 14743 .. 14765
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v641 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0641" 385875968 16777216

end CS31aData.N13
