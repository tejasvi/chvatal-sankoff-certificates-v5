import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1175 = cert_data/n13/h13c.vec.part1175, entries 113351065600 .. 113447534591, chunks 27025 .. 27047
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1175 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1175" 385875968 16777216

end CS31aData.N13
