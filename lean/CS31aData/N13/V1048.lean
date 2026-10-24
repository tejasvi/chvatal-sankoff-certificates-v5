import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1048 = cert_data/n13/h13c.vec.part1048, entries 101099503616 .. 101195972607, chunks 24104 .. 24126
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1048 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1048" 385875968 16777216

end CS31aData.N13
