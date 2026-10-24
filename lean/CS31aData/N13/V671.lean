import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 671 = cert_data/n13/h13c.vec.part0671, entries 64730693632 .. 64827162623, chunks 15433 .. 15455
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v671 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0671" 385875968 16777216

end CS31aData.N13
