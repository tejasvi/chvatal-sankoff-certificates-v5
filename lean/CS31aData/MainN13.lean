import CS31a.Assemble
import CS31a.CheckNative13
import CS31a.Count
import CS31a.CoverExists
import CS31aData.N13.C0
import CS31aData.N13.C1
import CS31aData.N13.C2
import CS31aData.N13.C3
import CS31aData.N13.C4
import CS31aData.N13.C5
import CS31aData.N13.C6
import CS31aData.N13.C7
import CS31aData.N13.C8
import CS31aData.N13.C9
import CS31aData.N13.C10
import CS31aData.N13.C11
import CS31aData.N13.C12
import CS31aData.N13.C13
import CS31aData.N13.C14
import CS31aData.N13.C15
import CS31aData.N13.C16
import CS31aData.N13.C17
import CS31aData.N13.C18
import CS31aData.N13.C19
import CS31aData.N13.C20
import CS31aData.N13.C21
import CS31aData.N13.C22
import CS31aData.N13.C23
import CS31aData.N13.C24
import CS31aData.N13.C25
import CS31aData.N13.C26
import CS31aData.N13.C27
import CS31aData.N13.C28
import CS31aData.N13.C29
import CS31aData.N13.C30
import CS31aData.N13.C31
import CS31aData.N13.C32
import CS31aData.N13.C33
import CS31aData.N13.C34
import CS31aData.N13.C35
import CS31aData.N13.C36
import CS31aData.N13.C37
import CS31aData.N13.C38
import CS31aData.N13.C39
import CS31aData.N13.C40
import CS31aData.N13.C41
import CS31aData.N13.C42
import CS31aData.N13.C43
import CS31aData.N13.C44
import CS31aData.N13.C45
import CS31aData.N13.C46
import CS31aData.N13.C47
import CS31aData.N13.C48
import CS31aData.N13.C49
import CS31aData.N13.C50
import CS31aData.N13.C51
import CS31aData.N13.C52
import CS31aData.N13.C53
import CS31aData.N13.C54
import CS31aData.N13.C55

/-! N13: `γ₂ ≤ 0.821963` from the native check of the compact certificate (h = 13, z = 0.3568: the h = 13 certificate of the paper (h13_keys.bin, 165695219469 sorted keys, sha256 8454e843e50a773f4fedfbf9dfc7aaf49df071b9a8ed3e275758a94f27d19828; h13_v.f32 sha256 b5456a64bdcc3a21e77cef50b964764af4be55c50b42b04a417777682a870fcb; weights w_h13_0.3568.txt; Λ = 8116075413730513074) in the compact layout of tools_compact13.cpp; whole-file and part sha256s in gen/n13_files.sha256 and gen/n13_parts.sha256), split over 56
machine shares (row ranges). The exact test uses `θ' = 3241/3943 ≤ 0.821963`. -/

namespace CS31aData

open CS31a CS31aCert

theorem rangesN13 : ∀ r ∈ ([(0, 2958843205, 320), (2958843205, 5917686410, 320), (5917686410, 8876529614, 320), (8876529614, 11835372819, 320), (11835372819, 14794216024, 320), (14794216024, 17753059229, 320), (17753059229, 20711902434, 320), (20711902434, 23670745638, 320), (23670745638, 26629588843, 320), (26629588843, 29588432048, 320), (29588432048, 32547275253, 320), (32547275253, 35506118458, 320), (35506118458, 38464961662, 320), (38464961662, 41423804867, 320), (41423804867, 44382648072, 320), (44382648072, 47341491277, 320), (47341491277, 50300334482, 320), (50300334482, 53259177686, 320), (53259177686, 56218020891, 320), (56218020891, 59176864096, 320), (59176864096, 62135707301, 320), (62135707301, 65094550506, 320), (65094550506, 68053393710, 320), (68053393710, 71012236915, 320), (71012236915, 73971080120, 320), (73971080120, 76929923325, 320), (76929923325, 79888766530, 320), (79888766530, 82847609734, 320), (82847609734, 85806452939, 320), (85806452939, 88765296144, 320), (88765296144, 91724139349, 320), (91724139349, 94682982554, 320), (94682982554, 97641825759, 320), (97641825759, 100600668963, 320), (100600668963, 103559512168, 320), (103559512168, 106518355373, 320), (106518355373, 109477198578, 320), (109477198578, 112436041783, 320), (112436041783, 115394884987, 320), (115394884987, 118353728192, 320), (118353728192, 121312571397, 320), (121312571397, 124271414602, 320), (124271414602, 127230257807, 320), (127230257807, 130189101011, 320), (130189101011, 133147944216, 320), (133147944216, 136106787421, 320), (136106787421, 139065630626, 320), (139065630626, 142024473831, 320), (142024473831, 144983317035, 320), (144983317035, 147942160240, 320), (147942160240, 150901003445, 320), (150901003445, 153859846650, 320), (153859846650, 156818689855, 320), (156818689855, 159777533059, 320), (159777533059, 162736376264, 320), (162736376264, 165695219469, 320)] : List (ℕ × ℕ × ℕ)),
    checkCert13R 13 lowN13 tabN13 vecN13 165695219469 20 3 4294967296 5 22 wtN13 8116075413730513074 r.1 r.2.1 r.2.2 = true := by
  intro r hr
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hr
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  exacts [N13.cert0, N13.cert1, N13.cert2, N13.cert3, N13.cert4, N13.cert5, N13.cert6, N13.cert7, N13.cert8, N13.cert9, N13.cert10, N13.cert11, N13.cert12, N13.cert13, N13.cert14, N13.cert15, N13.cert16, N13.cert17, N13.cert18, N13.cert19, N13.cert20, N13.cert21, N13.cert22, N13.cert23, N13.cert24, N13.cert25, N13.cert26, N13.cert27, N13.cert28, N13.cert29, N13.cert30, N13.cert31, N13.cert32, N13.cert33, N13.cert34, N13.cert35, N13.cert36, N13.cert37, N13.cert38, N13.cert39, N13.cert40, N13.cert41, N13.cert42, N13.cert43, N13.cert44, N13.cert45, N13.cert46, N13.cert47, N13.cert48, N13.cert49, N13.cert50, N13.cert51, N13.cert52, N13.cert53, N13.cert54, N13.cert55]

theorem coverN13 : ∀ i < 165695219469, ∃ r ∈ ([(0, 2958843205, 320), (2958843205, 5917686410, 320), (5917686410, 8876529614, 320), (8876529614, 11835372819, 320), (11835372819, 14794216024, 320), (14794216024, 17753059229, 320), (17753059229, 20711902434, 320), (20711902434, 23670745638, 320), (23670745638, 26629588843, 320), (26629588843, 29588432048, 320), (29588432048, 32547275253, 320), (32547275253, 35506118458, 320), (35506118458, 38464961662, 320), (38464961662, 41423804867, 320), (41423804867, 44382648072, 320), (44382648072, 47341491277, 320), (47341491277, 50300334482, 320), (50300334482, 53259177686, 320), (53259177686, 56218020891, 320), (56218020891, 59176864096, 320), (59176864096, 62135707301, 320), (62135707301, 65094550506, 320), (65094550506, 68053393710, 320), (68053393710, 71012236915, 320), (71012236915, 73971080120, 320), (73971080120, 76929923325, 320), (76929923325, 79888766530, 320), (79888766530, 82847609734, 320), (82847609734, 85806452939, 320), (85806452939, 88765296144, 320), (88765296144, 91724139349, 320), (91724139349, 94682982554, 320), (94682982554, 97641825759, 320), (97641825759, 100600668963, 320), (100600668963, 103559512168, 320), (103559512168, 106518355373, 320), (106518355373, 109477198578, 320), (109477198578, 112436041783, 320), (112436041783, 115394884987, 320), (115394884987, 118353728192, 320), (118353728192, 121312571397, 320), (121312571397, 124271414602, 320), (124271414602, 127230257807, 320), (127230257807, 130189101011, 320), (130189101011, 133147944216, 320), (133147944216, 136106787421, 320), (136106787421, 139065630626, 320), (139065630626, 142024473831, 320), (142024473831, 144983317035, 320), (144983317035, 147942160240, 320), (147942160240, 150901003445, 320), (150901003445, 153859846650, 320), (153859846650, 156818689855, 320), (156818689855, 159777533059, 320), (159777533059, 162736376264, 320), (162736376264, 165695219469, 320)] : List (ℕ × ℕ × ℕ)), r.1 ≤ i ∧ i < r.2.1 := by
  intro i hi
  by_cases h0 : i < 2958843205
  · exact ⟨(0, 2958843205, 320), by simp, by omega, h0⟩
  by_cases h1 : i < 5917686410
  · exact ⟨(2958843205, 5917686410, 320), by simp, by omega, h1⟩
  by_cases h2 : i < 8876529614
  · exact ⟨(5917686410, 8876529614, 320), by simp, by omega, h2⟩
  by_cases h3 : i < 11835372819
  · exact ⟨(8876529614, 11835372819, 320), by simp, by omega, h3⟩
  by_cases h4 : i < 14794216024
  · exact ⟨(11835372819, 14794216024, 320), by simp, by omega, h4⟩
  by_cases h5 : i < 17753059229
  · exact ⟨(14794216024, 17753059229, 320), by simp, by omega, h5⟩
  by_cases h6 : i < 20711902434
  · exact ⟨(17753059229, 20711902434, 320), by simp, by omega, h6⟩
  by_cases h7 : i < 23670745638
  · exact ⟨(20711902434, 23670745638, 320), by simp, by omega, h7⟩
  by_cases h8 : i < 26629588843
  · exact ⟨(23670745638, 26629588843, 320), by simp, by omega, h8⟩
  by_cases h9 : i < 29588432048
  · exact ⟨(26629588843, 29588432048, 320), by simp, by omega, h9⟩
  by_cases h10 : i < 32547275253
  · exact ⟨(29588432048, 32547275253, 320), by simp, by omega, h10⟩
  by_cases h11 : i < 35506118458
  · exact ⟨(32547275253, 35506118458, 320), by simp, by omega, h11⟩
  by_cases h12 : i < 38464961662
  · exact ⟨(35506118458, 38464961662, 320), by simp, by omega, h12⟩
  by_cases h13 : i < 41423804867
  · exact ⟨(38464961662, 41423804867, 320), by simp, by omega, h13⟩
  by_cases h14 : i < 44382648072
  · exact ⟨(41423804867, 44382648072, 320), by simp, by omega, h14⟩
  by_cases h15 : i < 47341491277
  · exact ⟨(44382648072, 47341491277, 320), by simp, by omega, h15⟩
  by_cases h16 : i < 50300334482
  · exact ⟨(47341491277, 50300334482, 320), by simp, by omega, h16⟩
  by_cases h17 : i < 53259177686
  · exact ⟨(50300334482, 53259177686, 320), by simp, by omega, h17⟩
  by_cases h18 : i < 56218020891
  · exact ⟨(53259177686, 56218020891, 320), by simp, by omega, h18⟩
  by_cases h19 : i < 59176864096
  · exact ⟨(56218020891, 59176864096, 320), by simp, by omega, h19⟩
  by_cases h20 : i < 62135707301
  · exact ⟨(59176864096, 62135707301, 320), by simp, by omega, h20⟩
  by_cases h21 : i < 65094550506
  · exact ⟨(62135707301, 65094550506, 320), by simp, by omega, h21⟩
  by_cases h22 : i < 68053393710
  · exact ⟨(65094550506, 68053393710, 320), by simp, by omega, h22⟩
  by_cases h23 : i < 71012236915
  · exact ⟨(68053393710, 71012236915, 320), by simp, by omega, h23⟩
  by_cases h24 : i < 73971080120
  · exact ⟨(71012236915, 73971080120, 320), by simp, by omega, h24⟩
  by_cases h25 : i < 76929923325
  · exact ⟨(73971080120, 76929923325, 320), by simp, by omega, h25⟩
  by_cases h26 : i < 79888766530
  · exact ⟨(76929923325, 79888766530, 320), by simp, by omega, h26⟩
  by_cases h27 : i < 82847609734
  · exact ⟨(79888766530, 82847609734, 320), by simp, by omega, h27⟩
  by_cases h28 : i < 85806452939
  · exact ⟨(82847609734, 85806452939, 320), by simp, by omega, h28⟩
  by_cases h29 : i < 88765296144
  · exact ⟨(85806452939, 88765296144, 320), by simp, by omega, h29⟩
  by_cases h30 : i < 91724139349
  · exact ⟨(88765296144, 91724139349, 320), by simp, by omega, h30⟩
  by_cases h31 : i < 94682982554
  · exact ⟨(91724139349, 94682982554, 320), by simp, by omega, h31⟩
  by_cases h32 : i < 97641825759
  · exact ⟨(94682982554, 97641825759, 320), by simp, by omega, h32⟩
  by_cases h33 : i < 100600668963
  · exact ⟨(97641825759, 100600668963, 320), by simp, by omega, h33⟩
  by_cases h34 : i < 103559512168
  · exact ⟨(100600668963, 103559512168, 320), by simp, by omega, h34⟩
  by_cases h35 : i < 106518355373
  · exact ⟨(103559512168, 106518355373, 320), by simp, by omega, h35⟩
  by_cases h36 : i < 109477198578
  · exact ⟨(106518355373, 109477198578, 320), by simp, by omega, h36⟩
  by_cases h37 : i < 112436041783
  · exact ⟨(109477198578, 112436041783, 320), by simp, by omega, h37⟩
  by_cases h38 : i < 115394884987
  · exact ⟨(112436041783, 115394884987, 320), by simp, by omega, h38⟩
  by_cases h39 : i < 118353728192
  · exact ⟨(115394884987, 118353728192, 320), by simp, by omega, h39⟩
  by_cases h40 : i < 121312571397
  · exact ⟨(118353728192, 121312571397, 320), by simp, by omega, h40⟩
  by_cases h41 : i < 124271414602
  · exact ⟨(121312571397, 124271414602, 320), by simp, by omega, h41⟩
  by_cases h42 : i < 127230257807
  · exact ⟨(124271414602, 127230257807, 320), by simp, by omega, h42⟩
  by_cases h43 : i < 130189101011
  · exact ⟨(127230257807, 130189101011, 320), by simp, by omega, h43⟩
  by_cases h44 : i < 133147944216
  · exact ⟨(130189101011, 133147944216, 320), by simp, by omega, h44⟩
  by_cases h45 : i < 136106787421
  · exact ⟨(133147944216, 136106787421, 320), by simp, by omega, h45⟩
  by_cases h46 : i < 139065630626
  · exact ⟨(136106787421, 139065630626, 320), by simp, by omega, h46⟩
  by_cases h47 : i < 142024473831
  · exact ⟨(139065630626, 142024473831, 320), by simp, by omega, h47⟩
  by_cases h48 : i < 144983317035
  · exact ⟨(142024473831, 144983317035, 320), by simp, by omega, h48⟩
  by_cases h49 : i < 147942160240
  · exact ⟨(144983317035, 147942160240, 320), by simp, by omega, h49⟩
  by_cases h50 : i < 150901003445
  · exact ⟨(147942160240, 150901003445, 320), by simp, by omega, h50⟩
  by_cases h51 : i < 153859846650
  · exact ⟨(150901003445, 153859846650, 320), by simp, by omega, h51⟩
  by_cases h52 : i < 156818689855
  · exact ⟨(153859846650, 156818689855, 320), by simp, by omega, h52⟩
  by_cases h53 : i < 159777533059
  · exact ⟨(156818689855, 159777533059, 320), by simp, by omega, h53⟩
  by_cases h54 : i < 162736376264
  · exact ⟨(159777533059, 162736376264, 320), by simp, by omega, h54⟩
  by_cases h55 : i < 165695219469
  · exact ⟨(162736376264, 165695219469, 320), by simp, by omega, h55⟩
  omega

theorem gamma2_le_n13_of (H : LuekerCriterion 13) : gamma2 ≤ 0.821963 := by
  obtain ⟨hfind, hrows, hglob⟩ := checkCert13R_soundR _ rangesN13 (0, 2958843205, 320) (by simp) coverN13
  have h1 := gamma2_le_of_rows H _ _ _ _ hfind hrows hglob (zn := 223) (zd := 625) (by norm_num) (by norm_num)
    (by decide +kernel) (p := 3241) (q := 3943) (by norm_num) (by norm_num) (by norm_num) (by decide +kernel)
  calc gamma2 ≤ ((3241 : ℕ) : ℝ) / ((3943 : ℕ) : ℝ) := h1
    _ ≤ 0.821963 := by norm_num

/-- **No hypotheses** (native check of the compact certificate N13): `γ₂ ≤ 0.821963`. -/
theorem gamma2_le_n13 : gamma2 ≤ 0.821963 := gamma2_le_n13_of (luekerCriterion 13)

end CS31aData
