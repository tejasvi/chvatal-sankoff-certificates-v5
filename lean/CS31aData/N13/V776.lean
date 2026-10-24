import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 776 = cert_data/n13/h13c.vec.part0776, entries 74859937792 .. 74956406783, chunks 17848 .. 17870
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v776 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0776" 385875968 16777216

end CS31aData.N13
