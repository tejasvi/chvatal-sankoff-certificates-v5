import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 850 = cert_data/n13/h13c.vec.part0850, entries 81998643200 .. 82095112191, chunks 19550 .. 19572
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v850 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0850" 385875968 16777216

end CS31aData.N13
