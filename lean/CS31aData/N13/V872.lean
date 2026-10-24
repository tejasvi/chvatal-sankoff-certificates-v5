import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 872 = cert_data/n13/h13c.vec.part0872, entries 84120961024 .. 84217430015, chunks 20056 .. 20078
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v872 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0872" 385875968 16777216

end CS31aData.N13
