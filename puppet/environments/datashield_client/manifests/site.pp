# Datashield client server
#
# Install R and datashield client packages. Install Rstudio and set up default user for login. By default this will also
# install Agate and a mongoDB database to hold the Agate data.
# This is an example please change to meet the needs of your install. Consider changing any passwords in this file!
#

class { ::datashield::client:
  rstudio       => true,                        # Install rstudio on the machine
  agate         => false,                       # Install Agate
  mongodb_user  => 'opaluser',                  # MongoDB root user username for MongoDB install needed by Agate
  mongodb_pass  => 'opalpass',                  # MongoDB root user password for MongoDB install needed by Agate
  firewall      => true,                        # Install the firewall on the machine
  create_user   => true,                        # Create a default user account with rstudio install
  user_name     => 'datashield-training-admin', # Name of user to create
  password_hash => '$6$vO.5qmEMH$MkUJgi2kQ6DBbQdQNAeL3S9v/wtXdd3CQ5lF47QBqt1kHy1tuHFo1Or3pIHWPkmsBLvwv5MlhTVaX.3sO2yNi/' # Password hash of user to create
}

user { 'datashield-training1':
   ensure     => present,
   password   => '$6$wdR61Wq9dj3Ng0$hfZUIEbQs4ABw3K5GuGrSlAf.vn78A1fVrkeT.kf3Y.yIu7enUMhAWVIKy9VW9ggOvXl2iT/iak2OeHhaSPb5/',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training2':
   ensure     => present,
   password   => '$6$LVCvUCJGJFQ$iG8mXQ4heAicq0y1UAoYSmHsjj4151sk2XfW12gDJsraw91QwpCp9en1Xdu9W51uszuC83fbnd22oOWY7SFkJ0',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training3':
   ensure     => present,
   password   => '$6$EVAk2rdr6$mNfxTbqZFvcNjjYdMYJlmwFZT3uVXwRBDjrVEQkylt8h3ClJbbergeNcgnJSx7VpXOmr0dSGSViiZdU0JM.4M.',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training4':
   ensure     => present,
   password   => '$6$oEZdD8jIaPU2R$cAeeHGGvjC2AmhSAsNEaQsvgk6h2PcC/RP/Y1lb1NCWUejdEfu4bWCOlLoihRWH19HiGY6vWi8fn8qrDSLh9m.',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training5':
   ensure     => present,
   password   => '$6$RR2wAAj8WEL$y9xPFzaWkGNzi7GsRziPBdDua3uzD3IyqmeVugXcEGdaouJ9WziEnCmWAhXfbQHAKz37YT8eND4qJDJ1PmFdl/',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training6':
   ensure     => present,
   password   => '$6$IsM5.V.Dbb03j/Fu$v2IGPvfGhveI8v3gkO/r/FZMGxUi0TNmxnVXAL.vusfte5HP8PyitHHyHGlChjIbyxLBkBpkDGkJ7MZgSIPix.',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training7':
   ensure     => present,
   password   => '$6$hPfuVEqn4kV6$y2oK6JfAqKluPzb2KrdZHLCnow.cYRlvlCO3SISuI59WFmgUX0GBCmAyiH1oWEyS5zW4FH42ODDuIMpXW8wkr1',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training8':
   ensure     => present,
   password   => '$6$CLwcvdPNBj/9WyT$qjto.K1Oyzvfz1pal7w.MrltQoWPzIT53XbWEAVUyeXpkZhaD2hhq8ix8MLLIb.r3IqV1CuoiVAeh6Cnoc5Qq.',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training9':
   ensure     => present,
   password   => '$6$HK.8Jn25Rb$rrAyAfI3s3nDd4grU8uQ6I/a5vz0pXwveeimPVXYyafrvRJ0aSfIfFOROUTlF.ctgPaJyTX7/vbzpSnnAjnyU1',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training10':
   ensure     => present,
   password   => '$6$1.CYFF6J$DHXqqfSWxxQzEoJXoeQ7bHSmGXUYbWMAo.Nutmj2k8WrZsLu6c24x67ltYyL01/iopmwrs6GhtwyqTiTGmqSy0',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training11':
   ensure     => present,
   password   => '$6$G/pJw28r.gIO$Gy4InFsdI.3bUYynqlrsTm417IdpLHLtRk1OHGP.U6IHdScABal6.SGlHTMRUuw0T7w09Qulfqnc/l6yKg7De1',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training12':
   ensure     => present,
   password   => '$6$aK/xz28gHwnL.h$438STasOp9Wy9JFcPJe9jMvns7ELDUPYIwhr.AU5H4GemKtJrWIGBV0U6wZ352HSDbF5V/bEbc4J1YiUI/l1s0',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training13':
   ensure     => present,
   password   => '$6$uQsqPEqFuX$VR0TnVLVFzFA8ngXTjnrJd4zDP5lmwMtSPiWnMURzpApaeIuWysosTFMqeUgMbeU1qgUXEUNVII/CdN4H7luU/',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training14':
   ensure     => present,
   password   => '$6$ryJjmpK92$5qEUEl28Q1pv1QMiNkOPXPoD4hPKtB68Cap2zuGFOLzLyZyXe1Xn9aLRJ2CHudjprLEhxfDrQfmmlv9iXPnh61',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training15':
   ensure     => present,
   password   => '$6$kq86nvr6pr7NDk4$S1yGQyheg25Q5e7Q9K2tVxRemBcwUbbpnQzpu9GDnfTCvIvHt3fY10sMGHjMiaAU9g.RQIrY3W9kHWV0jwzLK.',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training16':
   ensure     => present,
   password   => '$6$HYHH/0EBCo$C6ohUN.yPmIdpGzI/6TqY3bVKqb2J5kMWDJhrRH340t4fGxO.gieRISBNkY0zh9c3gz4ZOxyvA5CYsPCTVYDm.',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training17':
   ensure     => present,
   password   => '$6$zpgyAJAq/sxqZMZy$vS5HvNNJCRI1AOmBN4u80cBiJinySlQPm8QX6Z8.nRRpUa3FlLMAp3voH9iLslz/NiynDTaPpi7BbUIbLaRtx0',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training18':
   ensure     => present,
   password   => '$6$kSPhGGZMgmXQP$wrX7sxB6qFmIx.zqKmsx0uy5HPMugoUzBrvvbiTnz8tKgxuUxhSKRn.law8DZ6aNrcj6PS4yu9TcPNKtGkVrG1',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training19':
   ensure     => present,
   password   => '$6$ze/kr82Ecn9UVl$IjnH2/Nq1TZFRa4PZfHMdN6alSr/lQn01QCEfHZfNYKaX2tKIefS6X/kaylkUdvI2VXUYvddqmhuFQ19kh0HW.',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training20':
   ensure     => present,
   password   => '$6$auNj9vWyYk95n0$mSLfdlpqdJhqbhOQV6bvPzcsE6ZjClcjcVcbt8f.TKAGD2V6Pl787qZjqA/L07W0kXx2fVEBN.a70E/oNNG/T/',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training21':
   ensure     => present,
   password   => '$6$FpGJuNceGbfH$ZdayanCDkxzoThDmG3MMwZ0g972byFnQjNqka/o1bKM.ZJJS.Lq/xpBeOTiuVbMeNBscYTkh7Md7nk92jISob0',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training22':
   ensure     => present,
   password   => '$6$pC5ciarc1YXpGJ$6wOO8M3AunXkMMWDhcCQAjuhRBO0RQtMNDNR1m2Mvp2jov2diKb/jyukS1BdATDR.pPa.XqEa3YlDNMfAEtk61',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training23':
   ensure     => present,
   password   => '$6$EpKoJiKSznQ$rHvduVTBbCrIJgHsQ.TGn7PoxXK.4dwEiCZAmt3nfEsqUSiTs9TtQwZh95mgvpyoGoXPKJteMbM/Gz9zrsjM6/',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training24':
   ensure     => present,
   password   => '$6$WePUkq2j4xQiET50$0ZyOqxVE.9rjKCof5.G.zNuaJHbC2MXfn.5QOg7J9BqJgmuL8ddrcB3Wys1j4k3zqghKT5N13CTlQQQpQKEnC1',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training25':
   ensure     => present,
   password   => '$6$AZVktHVNKs$2dSkHPj2IcSlk5NgnZlTuncL31uQ5cA/9jcck.N30PhJYyhohQllLKVsMD5HkiPBb2ea3Zkh9t8O6rPlo8Wez.',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training26':
   ensure     => present,
   password   => '$6$0.DTuN3gyV6D6LQo$EPV0z9tYNFZMJSgE/Gsucr4DQBaXFPxBOX/a7UloW/mAA32bJyXX7sE0L31WeyWKm1//snerbma5Hi1XbmwWh1',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training27':
   ensure     => present,
   password   => '$6$XGluiD0rSK7ibNM$/uDUqzYLvAiP4TkKbuHxgidNw78uHddqKO7rwJFiaz1SlH2RoczzwQ/WNvOdY/FcyhYi9Y8hPy8D5FZno7PGg.',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training28':
   ensure     => present,
   password   => '$6$9grZIz78woisId$rF8XXsbMNBo76qJKVYlwhm7md78YhISsaVYgUfmIwGD/RKUozpzQ7POnmNGDM1Evb/N41Cn09lD0x6g0YCy5w.',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training29':
   ensure     => present,
   password   => '$6$108v9Yy18mL$x/XI5zjIe6yK49kHI0qf7kSkXg8mZNUHcCqEtkbRJNvwmjHghSbNK1Mz0mrChtJYeRfg3C2CcqqB0yz7ED7eF/',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training30':
   ensure     => present,
   password   => '$6$YyCwWgrGrdhv$dTf3GTZxn4ShDrXufDcaueYjgrZSklj8dlaqnln.tVhjsLj8xHd0g.k9O2P.KliDAV6v.wlBHQJIr1wMn1L.V1',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training31':
   ensure     => present,
   password   => '$6$THc7m4gA5H2be$sQp9gKmL5Ik144U0p1zVgd5Say5kCBrTCYZ3PO87H3PgNV4poe5hmXPoW8xaTQdra3vwf.H3s2w3/WqYCIuzv1',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training32':
   ensure     => present,
   password   => '$6$VUTI1.XSP0/NQb1$CEepiPDHNpHqXXEnMrqLHfC0W7AeveqbrYBDZi2quhTAbweA2g6q2Gu6LZDUdlwBTF5r75lAeMUDe5hM/CNfe/',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training33':
   ensure     => present,
   password   => '$6$xOLr8vCT/mnif9GE$LHIT.KjzAOIayZRtfdzmDaIhrfb0JSUUrM.r3Mu689xtvMVGBLqPEgMGVodbQH91AzUFBaNcwNB/RgfptV71T/',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training34':
   ensure     => present,
   password   => '$6$2Nle2UQiD$T9zMiqEZCh3DC4kyL84e3ySKmHZoke7gwb3IWMI8RGAOiC9LT5oBMDgUvIzsnN7snvhstuX52WJz.9sLQfyNZ1',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training35':
   ensure     => present,
   password   => '$6$8XA7D2HCrUKIn$FQ9WIqas1PaA.YmxeyJ93tfZA.sOL54nTk3EpqTMeQ4gFvWTdFWmWA.3AhtEgI77oYllWP2b3zZZ0PVCTfST3.',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training36':
   ensure     => present,
   password   => '$6$8V9V/tSQB$mxNV3WN8Uiuj80J9cEnIYOnS45uTiYhi2Ffnrge612/crP91t.f3DbrkLJXfTXPW/RR0mNY514TPT70De6psp0',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training37':
   ensure     => present,
   password   => '$6$oQ0k5ai65l$F7ZFKbg21.1cK7z/NbQxdwVaZtQVtWQyd8sOKIwXO.XMvK5ZEWRevQBxP52qWLiBbY1DXWOJBvdcmnccxkbh7/',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training38':
   ensure     => present,
   password   => '$6$0RFOu9KlMHONpt$AuWjWnJpoUVcx9wIRPSnDYr5ZlRQXCWlpe0yvhejWvZ8.VSSjYiMylCxGw4vPITvKxTD0WLn63oF5ImMgBki71',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training39':
   ensure     => present,
   password   => '$6$k8wOX1Boku3Jt6L$A5/WfKAGbBocH4fGC7N4LdxjZGS8ka1bSFGmkuy6DVHjA5GVhJy7xQJ7Z7jTlbu7JQFmQU4risSw3z7Kt.WkC0',
   managehome => true,
   before => Class[::datashield::client]
}

user { 'datashield-training40':
   ensure     => present,
   password   => '$6$ldAkwvdGl10dVQ$fUDuy.tquxdDb4uDbHQWYypX52C8.Xm0qTO78MzuiwZs4/T00.YnkXJqMcmA1rUgNs3sCIgdmKhlfMKCO2u9S/',
   managehome => true,
   before => Class[::datashield::client]
}

