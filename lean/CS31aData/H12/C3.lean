import CS31aData.H12

/-! h = 12, machine share 3 of 7: rows [9938959693, 13121741545). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
theorem cert3 : CS31aCert.checkCertChunksR2 12 keysH12 vecH12 22670087101 19 536870912 wtH12 7776813894375449830 9938959693 13121741545 448 = true := by
  native_decide

end CS31aData.H12
