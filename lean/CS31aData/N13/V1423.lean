import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1423 = cert_data/n13/h13c.vec.part1423, entries 137275375616 .. 137371844607, chunks 32729 .. 32751
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1423 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1423" 385875968 16777216

end CS31aData.N13
