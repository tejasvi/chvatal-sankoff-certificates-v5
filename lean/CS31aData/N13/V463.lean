import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 463 = cert_data/n13/h13c.vec.part0463, entries 44665143296 .. 44761612287, chunks 10649 .. 10671
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v463 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0463" 385875968 16777216

end CS31aData.N13
