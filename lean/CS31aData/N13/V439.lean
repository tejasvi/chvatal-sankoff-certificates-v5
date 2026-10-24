import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 439 = cert_data/n13/h13c.vec.part0439, entries 42349887488 .. 42446356479, chunks 10097 .. 10119
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v439 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0439" 385875968 16777216

end CS31aData.N13
