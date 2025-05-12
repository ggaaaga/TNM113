(
// Set tempo
~tempoInBPM = 120;

// Set the drum sequence
~woodBlockDictionary = Dictionary();
~woodBlockDictionary.put("disco", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,1,0,1, 1,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~woodBlockDictionary.put("rhumba", [1,0,0,0, 1,0,1,0, 0,0,1,0, 0,0,1,0,  1,0,0,0, 1,0,1,0, 0,0,1,0, 0,0,1,0,  1,0,0,0, 1,0,1,0, 0,0,1,0, 0,0,1,0,  1,0,0,0, 1,0,1,0, 0,0,1,0, 0,0,1,0]);
~woodBlockDictionary.put("slowrock", [0,0,0,0, 0,0,0,0, 0,0,1,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,1,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,1,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,1,0, 0,0,0,0]);
~woodBlockDictionary.put("mambo", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,1,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,1,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,1,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,1,0,0]);
~woodBlockDictionary.put("bossanova", [1,0,0,0, 0,0,1,0, 0,0,0,0, 1,0,0,0,  0,0,0,0, 1,0,0,0, 0,0,1,0, 0,0,0,0,  0,0,0,0, 0,0,1,0, 0,0,0,0, 1,0,0,0,  0,0,0,0, 1,0,0,0, 0,0,1,0, 0,0,0,0]);
~woodBlockDictionary.put("rocknroll", [0,0,1,1, 0,0,0,0, 0,0,1,1, 0,0,1,0,  0,0,1,1, 0,0,0,0, 0,0,1,1, 0,0,1,0,  0,0,1,1, 0,0,0,0, 0,0,1,1, 0,0,1,0,  0,0,1,1, 0,0,0,0, 0,0,1,1, 0,0,1,0]);
~woodBlockDictionary.put("chacha", [1,0,0,0, 1,0,0,0, 1,0,1,0, 1,0,0,0,  1,0,0,0, 1,0,0,0, 1,0,1,0, 1,0,0,0,  1,0,0,0, 1,0,0,0, 1,0,1,0, 1,0,0,0,  1,0,0,0, 1,0,0,0, 1,0,1,0, 1,0,0,0]);
~cowBellDictionary = Dictionary();
~cowBellDictionary.put("disco", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  1,0,0,1, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~cowBellDictionary.put("rhumba", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,1,0, 0,0,1,0]);
~cowBellDictionary.put("slowrock", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0,  1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~cowBellDictionary.put("mambo", [1,0,0,0, 1,0,0,0, 1,0,0,0, 0,0,0,0,  1,0,0,0, 1,0,0,0, 1,0,0,0, 0,0,0,0,  1,0,0,0, 1,0,0,0, 1,0,0,0, 0,0,0,0,  1,0,0,0, 1,0,0,0, 1,0,0,0, 0,0,0,0]);
~cowBellDictionary.put("bossanova", [1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~cowBellDictionary.put("rocknroll", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,1,0]);
~cowBellDictionary.put("chacha", [1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0,  1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0]);

~crashDictionary = Dictionary();
~crashDictionary.put("disco", [1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~crashDictionary.put("rhumba", [1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~crashDictionary.put("slowrock", [1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~crashDictionary.put("mambo", [1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~crashDictionary.put("bossanova", [1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~crashDictionary.put("rocknroll", [1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~crashDictionary.put("chacha", [1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~opHiHatDictionary = Dictionary();
~opHiHatDictionary.put("disco", [0,0,1,0, 0,0,1,0, 0,0,1,0, 0,0,1,0,  0,0,1,0, 0,0,1,0, 0,0,1,0, 0,0,1,0,  0,0,1,0, 0,0,1,0, 0,0,1,0, 0,0,1,0,  0,0,1,0, 0,0,1,0, 0,0,1,0, 0,0,1,0]);
~opHiHatDictionary.put("rhumba", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0]);
~opHiHatDictionary.put("slowrock", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,1,0, 0,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,1,0, 0,0,1,0]);
~opHiHatDictionary.put("mambo", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~opHiHatDictionary.put("bossanova", [0,0,1,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,1,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,1,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,1,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~opHiHatDictionary.put("rocknroll", [0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,0,  0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,0,  0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,0,  0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,0]);
~opHiHatDictionary.put("chacha", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0]);
~clHiHatDictionary = Dictionary();
~clHiHatDictionary.put("disco", [1,1,0,0, 1,0,0,0, 1,0,1,1, 1,1,0,1,  1,1,0,0, 1,0,0,0, 1,0,1,1, 1,1,0,1,  1,1,0,0, 1,0,0,0, 1,0,1,1, 1,1,0,1,  1,1,0,0, 1,0,0,0, 1,0,1,1, 1,1,0,1]);
~clHiHatDictionary.put("rhumba", [1,0,1,1, 1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,1, 1,1,1,0, 1,0,1,0, 1,0,1,1,  1,0,1,1, 1,1,1,0, 1,1,1,0, 1,0,1,0, 1,0,1,1, 1,1,1,0, 1,0,1,0, 1,0,1,1]);
~clHiHatDictionary.put("slowrock", [1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0,  1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0,  1,1,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0,  1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0]);
~clHiHatDictionary.put("mambo", [1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,0,1,  1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,0,1,  1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,0,1,  1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,0,1]);
~clHiHatDictionary.put("bossanova", [1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0,  1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0,  1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0,  1,0,1,0, 1,0,1,0, 1,0,1,0]);
~clHiHatDictionary.put("rocknroll", [1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0,  1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0,  1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0,  1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0]);
~clHiHatDictionary.put("chacha", [1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0,  1,0,1,0, 1,0,1,0, 1,0,1,0, 1,1,1,0,  1,0,1,0, 1,0,1,0, 1,0,1,0, 1,0,1,0,  1,0,1,0, 1,0,1,0, 1,0,1,0, 1,1,1,1]);

~snareDrumDictionary = Dictionary();
~snareDrumDictionary.put("disco", [0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,1,  0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,1,1,  0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,1,  0,0,0,0, 1,0,0,0, 0,0,0,0, 1,1,1,1]);
~snareDrumDictionary.put("rhumba", [0,0,0,0, 0,0,1,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,1,0, 0,0,0,0, 1,0,1,0,  0,0,0,0, 0,0,1,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,1,0, 0,0,0,0, 1,1,1,0]);
~snareDrumDictionary.put("slowrock", [0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,0,  0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,1,1,  0,0,0,0, 1,0,0,0, 0,0,0,0, 1,0,0,0,  0,0,0,0, 1,0,0,0, 0,0,1,1, 1,0,1,1]);
~snareDrumDictionary.put("mambo", [0,0,0,0, 0,0,0,0, 1,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 1,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 1,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 1,0,0,0, 0,0,0,0]);
~snareDrumDictionary.put("bossanova", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0]);
~snareDrumDictionary.put("rocknroll", [0,0,0,0, 0,0,0,0, 1,0,0,0, 0,0,1,0,  0,0,1,0, 0,0,0,0, 1,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 1,0,0,0, 0,0,1,0,  0,0,1,0, 0,0,0,0, 1,0,0,0, 0,0,0,0]);
~snareDrumDictionary.put("chacha", [1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,1,0,  1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,1,0]);
~highTomDictionary = Dictionary();
~highTomDictionary.put("disco", [0,0,0,0, 0,0,1,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~highTomDictionary.put("rhumba", [0,0,0,0, 0,0,1,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,1,0, 0,0,0,0, 1,0,1,0,  0,0,0,0, 0,0,1,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,1,0, 0,0,0,0, 1,1,1,0]);
~highTomDictionary.put("slowrock", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,1, 1,0,0,0]);
~highTomDictionary.put("mambo", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,1,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~highTomDictionary.put("bossanova", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,0]);
~highTomDictionary.put("rocknroll", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 1,1,0,0]);
~highTomDictionary.put("chacha", [1,0,0,0, 1,0,0,0, 1,0,1,0, 1,0,0,0,  1,0,0,0, 1,0,0,0, 1,0,1,0, 1,0,0,0,  1,0,0,0, 1,0,0,0, 1,0,1,0, 1,0,0,0,  1,0,0,0, 1,0,0,0, 1,0,1,0, 1,0,0,0]);
~lowTomDictionary = Dictionary();
~lowTomDictionary.put("disco", [0,0,0,0, 0,0,0,0, 1,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0]);
~lowTomDictionary.put("rhumba", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1]);
~lowTomDictionary.put("slowrock", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,1]);
~lowTomDictionary.put("mambo", [0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,1,0]);
~lowTomDictionary.put("bossanova", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,0,0]);
~lowTomDictionary.put("rocknroll", [0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,1,1]);
~lowTomDictionary.put("chacha", [0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,1,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 1,0,1,0]);
~bassDrumDictionary = Dictionary();
~bassDrumDictionary.put("disco", [1,0,0,0, 1,0,0,0, 1,0,0,0, 1,0,0,0,  1,0,0,0, 1,0,0,0, 1,0,0,0, 1,0,0,0,  1,0,0,0, 1,0,0,0, 1,0,0,0, 1,0,0,0,  1,0,0,0, 1,0,0,0, 1,0,0,0, 1,0,0,0]);
~bassDrumDictionary.put("rhumba", [1,0,0,0, 0,0,0,0, 1,0,0,0, 1,0,0,0,  1,0,0,0, 0,0,0,0, 1,0,0,0, 1,0,0,1,  1,0,0,0, 0,0,0,0, 1,0,0,0, 1,0,0,0,  1,0,0,0, 0,0,0,0, 1,0,0,0, 1,0,0,0]);
~bassDrumDictionary.put("slowrock", [1,0,0,0, 0,0,1,0, 1,0,0,0, 0,0,0,0,  1,0,0,0, 0,0,1,0, 1,0,0,0, 0,0,0,0,  1,0,0,0, 0,0,1,0, 1,0,0,0, 0,0,0,0,  1,0,0,0, 0,0,1,0, 1,0,0,0, 0,0,0,0]);
~bassDrumDictionary.put("mambo", [1,0,0,0, 0,0,1,0, 0,0,0,0, 1,0,0,0,  1,0,0,0, 0,0,1,0, 0,0,0,0, 1,0,0,0,  1,0,0,0, 0,0,1,0, 0,0,0,0, 1,0,0,0,  1,0,0,0, 0,0,1,0, 0,0,0,0, 1,0,0,0]);
~bassDrumDictionary.put("bossanova", [1,0,0,0, 0,0,1,0, 1,0,0,0, 0,0,0,0,  1,0,0,0, 0,0,1,0, 1,0,0,0, 0,0,0,0,  1,0,0,0, 0,0,1,0, 1,0,0,0, 0,0,0,0,  1,0,0,0, 0,0,1,0, 1,0,0,0, 0,0,0,0]);
~bassDrumDictionary.put("rocknroll", [1,0,0,0, 1,0,0,0, 0,0,0,0, 0,0,0,0,  1,0,0,0, 1,0,0,0, 0,0,0,0, 0,0,0,0,  1,0,0,0, 1,0,0,0, 0,0,0,0, 0,0,0,0,  1,0,0,0, 1,0,0,0, 0,0,0,0, 0,0,0,0]);
~bassDrumDictionary.put("chacha", [1,0,0,0, 0,0,1,0, 0,0,0,0, 1,0,0,0,  1,0,0,0, 0,0,1,0, 1,0,0,0, 1,0,0,0,  1,0,0,0, 0,0,1,0, 0,0,0,0, 1,0,0,0,  1,0,0,0, 0,0,1,0, 1,0,0,0, 1,0,0,0]);



~drumStyle = "disco";

~setDrumstyle = {
	~woodBlockTrig = ~woodBlockDictionary[~drumStyle];
	~cowBellTrig = ~cowBellDictionary[~drumStyle];

	~crashTrig = ~crashDictionary[~drumStyle];
	~opHiHatTrig = ~opHiHatDictionary[~drumStyle];
	~clHiHatTrig = ~clHiHatDictionary[~drumStyle];

	~snareDrumTrig = ~snareDrumDictionary[~drumStyle];
	~highTomTrig = ~highTomDictionary[~drumStyle];
	~lowTomTrig = ~lowTomDictionary[~drumStyle];
	~bassDrumTrig = ~bassDrumDictionary[~drumStyle];
};

// Declare synth instances
~woodBlock = Synth.new(\woodBlock).register;
~cowBell = Synth.new(\cowBell).register;

~crash = Synth.new(\crash).register;
~opHiHat = Synth.new(\opHiHat).register;
~clHiHat = Synth.new(\clHiHat).register;

~snareDrum = Synth.new(\snareDrum).register;
~highTom = Synth.new(\highTom).register;
~lowTom = Synth.new(\lowTom).register;
~bassDrum = Synth.new(\bassDrum).register;


~waitTime = 60 / ~tempoInBPM / 4;

// The drum sequencer task
~drumSequencer = Task({
	{
		// Send triggers to the drum synths
		if (~woodBlockTrig[~beatStepCounter] == 1) {
			~woodBlock.set(\t_trig, ~woodBlockTrig[~beatStepCounter]);
		};
		if (~cowBellTrig[~beatStepCounter] == 1) {
			~cowBell.set(\t_trig, ~cowBellTrig[~beatStepCounter]);
		};
		if (~crashTrig[~beatStepCounter] == 1) {
			~crash.set(\t_trig, ~crashTrig[~beatStepCounter]);
		};
		if (~opHiHatTrig[~beatStepCounter] == 1) {
			~opHiHat.set(\t_trig, ~opHiHatTrig[~beatStepCounter]);
		};
		if (~clHiHatTrig[~beatStepCounter] == 1) {
			~clHiHat.set(\t_trig, ~clHiHatTrig[~beatStepCounter]);
		};
		if (~snareDrumTrig[~beatStepCounter] == 1) {
			~snareDrum.set(\t_trig, ~snareDrumTrig[~beatStepCounter]);
		};
		if (~highTomTrig[~beatStepCounter] == 1) {
			~highTom.set(\t_trig, ~highTomTrig[~beatStepCounter]);
		};
		if (~lowTomTrig[~beatStepCounter] == 1) {
			~lowTom.set(\t_trig, ~lowTomTrig[~beatStepCounter]);
		};
		if (~bassDrumTrig[~beatStepCounter] == 1) {
			~bassDrum.set(\t_trig, ~bassDrumTrig[~beatStepCounter]);
		};

		// Take care of the counter
		~beatStepCounter = ~beatStepCounter + 1;
		if (~beatStepCounter == 64) {
			~beatStepCounter = 0;
		};

		// Set the tempo by waiting in seconds
		~waitTime.wait;
	}.loop;
});

// ----------------
// En del GUI-grejer
~windowWidth = Window.screenBounds.right;
~windowHeight = Window.screenBounds.bottom;
~guiPosX = ((~windowWidth/2) - (800/2));
~guiPosY = ((~windowHeight/2) - (200/2));
w = Window.new("Drum Machine",
	Rect.new(
		~guiPosX,
		~guiPosY,
		800,
		200))
.front
.background_(Color.new255(200,200,200,255));
w.onClose_({~closeRoutine.value});

~viewForLEDs = UserView(w, Rect(0, 0, 800, 200));
~viewForLEDs.drawFunc = {
	Pen.fillColor = Color.new255(0, 0, 0, 100);
	Pen.use({
		Pen.fillOval(Rect.aboutPoint(Point(55, 100), 10, 10));
		Pen.fillOval(Rect.aboutPoint(Point(145, 100), 10, 10));
		Pen.fillOval(Rect.aboutPoint(Point(235, 100), 10, 10));
		Pen.fillOval(Rect.aboutPoint(Point(325, 100), 10, 10));
		Pen.fillOval(Rect.aboutPoint(Point(415, 100), 10, 10));
		Pen.fillOval(Rect.aboutPoint(Point(505, 100), 10, 10));
		Pen.fillOval(Rect.aboutPoint(Point(595, 100), 10, 10));
		Pen.fill;
	});
};
~viewForLED = UserView(w, Rect(35, 80, 50, 50));
~viewForLED.drawFunc = {
	Pen.fillColor = Color.new255(255, 100, 100, 200);
	Pen.use({
		Pen.fillOval(Rect.aboutPoint(Point(20, 20), 10, 10));
		Pen.fill;
		Pen.fillColor = Color.new255(255, 0, 0, 50);
		Pen.fillOval(Rect.aboutPoint(Point(20, 20), 20, 20));
	});
};

~discoButton = Button(w, Rect(15, 140, 80, 40))
.states_([
	["Disco"],
])
.action_({ arg button;
	~drumStyle = "disco";
	~setDrumstyle.value();
	~viewForLED.moveTo(35, 80);
});

~rhumbaButton = Button(w, Rect(105, 140, 80, 40))
.states_([
	["Rhumba"],
])
.action_({ arg button;
	~drumStyle = "rhumba";
	~setDrumstyle.value();
	~viewForLED.moveTo(125, 80);
});
~slowRockButton = Button(w, Rect(195, 140, 80, 40))
.states_([
	["Slowrock"],
])
.action_({ arg button;
	~drumStyle = "slowrock";
	~setDrumstyle.value();
	~viewForLED.moveTo(215, 80);
});
~mamboButton = Button(w, Rect(285, 140, 80, 40))
.states_([
	["Mambo"],
])
.action_({ arg button;
	~drumStyle = "mambo";
	~setDrumstyle.value();
	~viewForLED.moveTo(305, 80);
});
~bossaButton = Button(w, Rect(375, 140, 80, 40))
.states_([
	["Bossanova"],
])
.action_({ arg button;
	~drumStyle = "bossanova";
	~setDrumstyle.value();
	~viewForLED.moveTo(395, 80);
});
~rockButton = Button(w, Rect(465, 140, 80, 40))
.states_([
	["Rock'n roll"],
])
.action_({ arg button;
	~drumStyle = "rocknroll";
	~setDrumstyle.value();
	~viewForLED.moveTo(485, 80);
});
~chachaButton = Button(w, Rect(555, 140, 80, 40))
.states_([
	["Cha-cha"],
])
.action_({ arg button;
	~drumStyle = "chacha";
	~setDrumstyle.value();
	~viewForLED.moveTo(575, 80);
});

~playButton = Button(w, Rect(720, 80, 60, 40))
.states_([
	["Play"],
])
.action_({ arg button;
	~setDrumstyle.value();
	~beatStepCounter = 0;
	~drumSequencer.start;

});
~stopButton = Button(w, Rect(720, 140, 60, 40))
.states_([
	["Stop"],
])
.action_({ arg button;
	~drumSequencer.stop;

});

k = Knob.new(w, Rect(650,120,60,60));
k.action_({ arg v,x,y,m;
	~tempoInBPM = linlin(v.value, 0, 1, 60, 180);
	a.string = ~tempoInBPM.asInteger;
	~waitTime = 60 / ~tempoInBPM / 4;

})
.centered_(false)
.value_(0.5);

a = StaticText(w, Rect(650, 90, 55, 20));
a.string = ~tempoInBPM;
a.align = \center;

~heading = StaticText(w, Rect(20, 20, 800, 40));
~heading.font = Font("Monaco", 36);
~heading.string = "TNM113 - 70/80s drum machine";
~heading.align = \left;

// Följande stänger fönstret och OSC-lyssnaren när man stänger av processen i
// SC med <ctrl> & <enter> i Windows och <cmd> & <enter> i MacOS
CmdPeriod.doOnce({
	w.free;
	w.close;
	o.free;
	o.remove;
});
// ----------------
// Closing routine
~closeRoutine = Routine({
	o.free;
	o.remove;
});

)
~drumSequencer.stop;
ServerMeter.new(s, 0, 2);
s.scope;

