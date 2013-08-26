describe "StringSplitter", ->

  beforeEach ->
    module = require('../../src/js/StringSplitter.js')
    @StringSplitter = new module.StringSplitter()

  describe "nextPositionIn", ->
    it "should be the same as the text length", ->
      text = 'x.x,x'
      i = @StringSplitter.nextPositionIn(text)
      expect(i).toBe text.length

    it "should get the first dot", ->
      text = 'x. x,x'
      @StringSplitter.setCharacterLimit(4)
      i = @StringSplitter.nextPositionIn(text)
      expect(i).toBe text.lastIndexOf('.')

    it "should get the correct position in french", ->
      text = 'Jean VI de Portugal (en portugais : João VI de Portugal), roi de Portugal et des Algarves et roi puis empereur titulaire du Brésil, est né à Lisbonne, au Portugal, le 13 mai 1767 et décédé dans cette même ville le 10 mars 1826. Surnommé « le Clément », il règne sur le Royaume uni de Portugal, du Brésil et des Algarves de 1816 a 1822 puis sur le seul royaume de Portugal de 1822 à 1826. Grâce au traité de Rio de Janeiro de 1825, qui reconnaît l\'indépendance du Brésil, Jean VI est également proclamé empereur titulaire du Brésil, mais c\'est son fils aîné, l\'empereur Pierre I, qui est le véritable souverain du pays pendant son règne.'
      @StringSplitter.setCharacterLimit(150)
      i = @StringSplitter.nextPositionIn(text)
      expect(i).toBe text.lastIndexOf(',', 150)

    it "should get the correct position in french", ->
      # text = 'Jean VI de Portugal (en portugais : João VI de Portugal), roi de Portugal et des Algarves et roi puis empereur titulaire du Brésil, est né à Lisbonne, au Portugal, le 13 mai 1767 et décédé dans cette même ville le 10 mars 1826. Surnommé « le Clément », il règne sur le Royaume uni de Portugal, du Brésil et des Algarves de 1816 a 1822 puis sur le seul royaume de Portugal de 1822 à 1826. Grâce au traité de Rio de Janeiro de 1825, qui reconnaît l\'indépendance du Brésil, Jean VI est également proclamé empereur titulaire du Brésil, mais c\'est son fils aîné, l\'empereur Pierre I, qui est le véritable souverain du pays pendant son règne.'
      text = 'Jean VI de Portugal (en portugais : Joo VI de Portugal) roi '#de Portugal et des Algarves et roi puis empereur titulaire du Brsil, est n  Lisbonne, au Portugal, le 13 mai 1767 et dcd dans cette mme ville le 10 mars 1826. Surnomm le Clment, il rgne sur le Royaume uni de Portugal # , du Brsil et des Algarves de 1816 a 1822 puis sur le seul royaume de Portugal de 1822  1826. Grce au trait de Rio de Janeiro de 1825, qui reconnat l\'indpendance du Brsil, Jean VI est galement proclam empereur titulaire du Brsil, mais c\'est son fils an l\'empereur Pierre I, qui est le vritable souverain du pays pendant son rgne'
      @StringSplitter.setCharacterLimit(150)
      i = @StringSplitter.nextPositionIn(text)
      expect(i).toBe text.length

  describe "stringsOf", ->
    it "should get the correct strings", ->
      text = 'x. x,x'
      @StringSplitter.setCharacterLimit(4)
      strings = @StringSplitter.stringsOf(text)
      expect(strings).toEqual ['x.', ' x,x']

    it "should get the correct strings of french", ->
      text = 'Jean VI de Portugal (en portugais : João VI de Portugal), roi de Portugal et des Algarves et roi puis empereur titulaire du Brésil, est né à Lisbonne, au Portugal, le 13 mai 1767 et décédé dans cette même ville le 10 mars 1826. Surnommé « le Clément », il règne sur le Royaume uni de Portugal, du Brésil et des Algarves de 1816 a 1822 puis sur le seul royaume de Portugal de 1822 à 1826. Grâce au traité de Rio de Janeiro de 1825, qui reconnaît l\'indépendance du Brésil, Jean VI est également proclamé empereur titulaire du Brésil, mais c\'est son fils aîné, l\'empereur Pierre I, qui est le véritable souverain du pays pendant son règne.'
      @StringSplitter.setCharacterLimit(150)
      strings = @StringSplitter.stringsOf(text)
      expect(strings).toEqual [ 'Jean VI de Portugal (en portugais : João VI de Portugal), roi de Portugal et des Algarves et roi puis empereur titulaire du Brésil, est né à Lisbonne,', ' au Portugal, le 13 mai 1767 et décédé dans cette même ville le 10 mars 1826.', ' Surnommé « le Clément », il règne sur le Royaume uni de Portugal,', ' du Brésil et des Algarves de 1816 a 1822 puis sur le seul royaume de Portugal de 1822 à 1826.', ' Grâce au traité de Rio de Janeiro de 1825, qui reconnaît l\'indépendance du Brésil, Jean VI est également proclamé empereur titulaire du Brésil,', ' mais c\'est son fils aîné, l\'empereur Pierre I, qui est le véritable souverain du pays pendant son règne.' ]


    it "should get the correct strings of french again", ->
      text = "Incapable de résister à l'attaque du général Junot, le prince Jean prend la décision de fuir son royaume et de transférer la cour et le gouvernement au Brésil, qui est alors la plus prospère des colonies portugaises. Après plusieurs semaines de tribulations, la famille royale et les 500 à 15 000 personnes qui l'accompagnent (selon les sources) s'installent donc à Rio de Janeiro le 7 mars 1808. En compagnie de ses conseillers, le régent met rapidement en place une série de réformes qui ouvrent le Brésil au commerce international et le dotent d'institutions stables et modernes."
      @StringSplitter.setCharacterLimit(150)
      strings = @StringSplitter.stringsOf(text)
      expect(strings).toEqual [ 'Incapable de résister à l\'attaque du général Junot,', ' le prince Jean prend la décision de fuir son royaume et de transférer la cour et le gouvernement au Brésil,', ' qui est alors la plus prospère des colonies portugaises.', ' Après plusieurs semaines de tribulations,', ' la famille royale et les 500 à 15 000 personnes qui l\'accompagnent (selon les sources) s\'installent donc à Rio de Janeiro le 7 mars 1808.', ' En compagnie de ses conseillers,', ' le régent met rapidement en place une série de réformes qui ouvrent le Brésil au commerce international et le dotent d\'institutions stables et ', 'modernes.' ]

