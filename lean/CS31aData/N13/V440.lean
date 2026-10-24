import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 440 = cert_data/n13/h13c.vec.part0440, entries 42446356480 .. 42542825471, chunks 10120 .. 10142
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v440 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0440" 385875968 16777216

end CS31aData.N13
