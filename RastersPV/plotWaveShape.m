function plotWaveShape(path, FileBase, IDsh, cluNo, neuNo)

% plot the wave shape of one cluster
% e.g.: plotWaveShape('Z:\Raphael_tests\mice_expdata\ANM016\A016-20190603\A016-20190603-01\','A016-20190603-01',4,3,49)


cluFilename = [path FileBase '.clu.' num2str(IDsh)];
spkFilename = [path FileBase '.spk.' num2str(IDsh)];
xmlFilename = [path FileBase '.xml'];
        
xml = LoadXml_e(xmlFilename(1:end-4));

%------------------------------------------------------------------------
% calcualte values if no stored data
%------------------------------------------------------------------------
SampleRate = 1e6./xml.SampleTime;
SpkSamples = xml.SpkGrps(1).nSamples;

% load all data
[nClusters, Clu] = LoadClu_e1(cluFilename);

nspk = FileLength(spkFilename)/2/length(xml.ElecGp{IDsh})/SpkSamples;
if nspk ~= length(Clu)
    fprintf('%s - Electrode %d - length of spk file does not correspond to clu length\n\n',FileBase,IDsh);
end

load([path FileBase '-param.mat']); 
device.RecSyst.amplification = 400;
voltNorm = (1/(2^device.RecSyst.ADresolution)) ...
    * device.RecSyst.ADvoltRange ...
    * (1/device.RecSyst.amplification) * 1000000;


%------------------------------------------------------------------------
%load only enough spike to sample all clusters
% create represantative spikes sample for good cells
avSpk =[]; stdSpk = [];
count = 1;
for cnum=cluNo
    % get spike wavesdhapes and compute SNR
    SampleSize = 100;
    myClu=find(Clu==cnum);
    
    if length(myClu)>2
        SampleSize = min(length(myClu),SampleSize);
        RndSample = sort(myClu(randsample(length(myClu),SampleSize)));
        mySpk = LoadSpkPartial_e1(spkFilename,length(xml.ElecGp{IDsh}),SpkSamples,RndSample);
        mySpk = mySpk * voltNorm;
        
        avSpk(:,:,cnum) = squeeze(mean(mySpk, 3));
        stdSpk(:,:,cnum)  = squeeze(std(mySpk,0,3));% may not need it
                
        %find the channel of largest amp (positive or negative)
        [amps ampch] = max(abs(avSpk(:,:,cnum)),[],2);
        [dummy maxampch] = max(squeeze(amps));
        
        myAvSpk = squeeze(avSpk(maxampch,:,cnum)); % largest channel spike wave for that cluster
        myStdSpk = squeeze(stdSpk(maxampch,:,cnum));
        
        mySpkMax = squeeze(mySpk(maxampch,:,:));
        
%         %% plot average wave shape
%         [figNew,pos] = CreateFig();
%         set(0,'Units','pixels') 
%         set(figure(figNew),'OuterPosition',...
%             [500 500 280 280])
%         
%         options.handle     = figure(figNew);
%         options.color_area = [27 117 187]./255;    % Blue theme
%         options.color_line= [ 39 169 225]./255;
%         options.alpha      = 0.5;
%         options.line_width = 2;
%         options.error      = 'std';
%         options.x_axis = (1:SpkSamples)/SampleRate;
%         plot_areaerrorbarSub(mySpkMax',options); 
%         xlabel('Time (s)')
%         ylabel('Amplitude (uV)')
%         
%         print ('-painters', '-dpdf', ['spikeWaveAvg_' FileBase '_Sh' num2str(IDsh) '_Clu' num2str(cnum) '_Neu' num2str(neuNo(count))], '-r600')
        
        %% plot the example wave shapes
        [figNew,pos] = CreateFig();
        set(0,'Units','pixels') 
        set(figure(figNew),'OuterPosition',...
            [500 500 280 280])
        
        h = plot((1:SpkSamples)/SampleRate,mySpkMax);
        set(h,'LineWidth',1,'Color',[0.7 0.7 0.7]);
%         set(gca,'FontSize',14.0,'YLim', [0 720]); 
        hold on;
        h = plot((1:SpkSamples)/SampleRate,myAvSpk);
        set(h,'LineWidth',1.5,'Color',[0 0 0]);
        xlabel('Time (s)')
        ylabel('Amplitude (uV)')
        
        print ('-painters', '-dpdf', ['spikeWave_' FileBase '_Sh' num2str(IDsh) '_Clu' num2str(cnum) '_Neu' num2str(neuNo(count))], '-r600')
        count = count + 1;
    end
    
end
























