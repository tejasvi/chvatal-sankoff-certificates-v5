import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 758 = cert_data/n13/h13c.vec.part0758, entries 73123495936 .. 73219964927, chunks 17434 .. 17456
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v758 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0758" 385875968 16777216

end CS31aData.N13
