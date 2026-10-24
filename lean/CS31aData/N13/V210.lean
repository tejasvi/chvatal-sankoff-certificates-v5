import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 210 = cert_data/n13/h13c.vec.part0210, entries 20258488320 .. 20354957311, chunks 4830 .. 4852
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v210 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0210" 385875968 16777216

end CS31aData.N13
