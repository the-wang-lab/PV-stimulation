sampleFq = 1250;

methodTheta = 1;
minFR = 0.15;
maxFR = 7;

spaceBin = 20;
intervalT = 10;
intervalTPopCorr = 20;
intervalD = 1800;

minFRInt = 3;

nSampBef = 3*sampleFq; % used in align to running onset

minNumGoodTr = 15;

anmNoInact = [41, 42, 46, 53, 54];
anmNoAct = [22 23 37 39 24 25 40 44 50 52 55 56]; % for pulse method 2
%anmNoAct{2} = [40 44]; % for pulse method 3 and stim at 50 cm
%anmNoAct{3} = [22 23 24 25]; % for pulse method 3 and stim at 70 cm
%anmNoAct{4} = [50 52 55 56]; % % for pulse method 3 and stim at 120 cm
pulseMethod{1} = [2 4]; % inactivation
pulseMethod{2} = [2 3]; % activation

excludeRec = [66 69 70 71 83 88]; % excluded recordings for PV activation mid cue

% significance probability
p = [99.9,99,95];
numShuffle = 1000;