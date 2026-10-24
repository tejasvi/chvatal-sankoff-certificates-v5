import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 346 = cert_data/n13/h13c.vec.part0346, entries 33378271232 .. 33474740223, chunks 7958 .. 7980
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v346 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0346" 385875968 16777216

end CS31aData.N13
