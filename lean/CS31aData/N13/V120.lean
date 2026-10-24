import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 120 = cert_data/n13/h13c.vec.part0120, entries 11576279040 .. 11672748031, chunks 2760 .. 2782
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v120 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0120" 385875968 16777216

end CS31aData.N13
