import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 23 = cert_data/n13/h13c.vec.part0023, entries 2218786816 .. 2315255807, chunks 529 .. 551
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v23 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0023" 385875968 16777216

end CS31aData.N13
