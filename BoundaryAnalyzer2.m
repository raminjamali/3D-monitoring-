function BoundaryAnalyzer2
global Add Grain GrainProf Image MeanDitch MeanStep HlineR HlineL x1 x2 y1 y2 c L Step Ditch hLPlot hsub11 hLPlot11
hLPlot='axe';
%% Side Bar
  MainDim=[10 100 1000 570];
  SideBotDim=[20 10 170 30];
  hGui = figure('Name','rDHM Metallography Grain Boundary Analyzer','Position',MainDim,...
                   'MenuBar','none');       
%  Min = uicontrol(hGui,'Style','text',...
%                     'Position',SideBotDim+[0 7*50 0 0],...
%                     'String',sprintf('Minimum height:\n'),...
%                     'HorizontalAlignment','center');
  Append = uicontrol(hGui,'Style','pushbutton',...
                      'Position',SideBotDim+[0 9*50 0 0],...
                      'String',sprintf('Append data of a hologram'),...
                      'HorizontalAlignment','center',...
                      'Callback',@Append_button);    
  MeanS = uicontrol(hGui,'Style','text',...
                    'Position',SideBotDim+[0 8*50 0 0],...
                    'String',sprintf('Mean step:\n'),...
                    'HorizontalAlignment','center');
  MeanD = uicontrol(hGui,'Style','text',...
                    'Position',SideBotDim+[0 7*50 0 0],...
                    'String',sprintf('Mean ditch:\n'),...
                    'HorizontalAlignment','center');
  Recon = uicontrol(hGui,'Style','pushbutton',...
                      'Position',SideBotDim+[0 6*50 0 0],...
                      'String','Import phasemap',...
                      'HorizontalAlignment','center',...
                      'Callback',@Recon_button);                       
  Tilt = uicontrol(hGui,'Style','pushbutton',...
                      'Position',SideBotDim+[0 5*50 0 0],...
                      'String','Tilt Removal',...
                      'HorizontalAlignment','center',...
                      'Callback',@Tilt_button);            
  Bound = uicontrol(hGui,'Style','pushbutton',...
                      'Position',SideBotDim+[0 4*50 0 0],...
                      'String','Boundary selection',...
                      'HorizontalAlignment','center',...
                      'Enable', 'on',...
                      'Callback',@Bound_button);
  Exclude = uicontrol(hGui,'Style','pushbutton',...
                      'Position',SideBotDim+[0 3*50 0 0],...
                      'String','Exclude from calculation',...
                      'HorizontalAlignment','center',...
                      'Enable', 'on',...
                      'Callback',@Exclude_button);              
  Save = uicontrol(hGui,'Style','pushbutton',...
                      'Position',SideBotDim+[0 2*50 0 0],...
                      'String','Save...',...
                      'HorizontalAlignment','center',...
                      'Enable', 'on',...
                      'Callback',@save_button);
  CloseBut = uicontrol(hGui,'Style','pushbutton',...
                      'Position',SideBotDim+[0 1*50 0 0],...
                      'String','Close',...
                      'HorizontalAlignment','center',...
                      'Callback',@close_button);                  
  Slider = uicontrol(hGui,'Style', 'slider',...
                      'Min',1,'Max',3,'Value',1,'SliderStep',[1 1],...
                      'Position', [20 30 200 20],...
                      'Callback',@Slider_button);
%% Figures and Plots
Ratio=[MainDim(3) MainDim(4) MainDim(3) MainDim(4)];
DimFig1=[50+SideBotDim(1)+SideBotDim(3) 350 340 180];
DimFig11=[40+DimFig1(1)+DimFig1(3) 350 340 180];
DimFig2=[50+SideBotDim(1)+SideBotDim(3) 80 720 180];
hsub1=subplot('Position',DimFig1./Ratio);title('Selected region (red line)')
hsub11=subplot('Position',DimFig11./Ratio);title('Selected region (red line)')
hsub2=subplot('Position',DimFig2./Ratio);
title('Height profile along the selected region')
%%

  function Append_button(hObject,eventData)
      file='file';
      add='add';
      AppendHeight=[];
      while 2>1
          [file,add]=uigetfile('*.mat',[],add);
          if ~isa(file,'char')
              break
          end
          LoadedHeight=load([add,file],'Height');
          IsHeight=fieldnames(LoadedHeight);
          if min(size(IsHeight))>0 && strcmp(IsHeight{1},'Height')
                        LoadedHeight.Height=reshape(LoadedHeight.Height,[1 max(size(LoadedHeight.Height))]);
              AppendHeight=[AppendHeight LoadedHeight.Height];
          else
              Error=errordlg('There is no variable "Height" in the selected mat file. Select again please.');
              waitfor(Error);
              continue
          end
      end
      TotVarHeight=var(AppendHeight);    TotMeanHeight=mean(AppendHeight);
      [file,add]=uiputfile('*.mat',[],add);
      save([add,file],'TotVarHeight','TotMeanHeight','AppendHeight')
  end
  function Recon_button(hObject,eventData)
      [Image,Add]=imget;
      Image=im2double(mean(Image,3));
      open('VIS_NF_GUI.fig')
  end
  function Tilt_button(hObject,eventData)
      z=evalin('base','h1');      
      [x,y] = meshgrid(1:size(z,2),1:size(z,1));
      P = polyfitn([x(:),y(:)],z(:),'x, y, constant');
      C=P.Coefficients;
      P=C(1).*x+C(2).*y+C(3);
      z2=z-P;
      assignin('base', 'h1', z2)
      figure;mesh(z);figure;mesh(z2);
  end
  function Exclude_button(hObject,eventData)
    k = fix(get(Slider,'Value'));
    L{k}=0.*ones(size(L{1}));
    Step(k)=0;
    Ditch(k)=0;
    aq=find(Step>0);
    MeanStep=sum(Step)./max(size(aq));
    aq=find(Ditch>0);
    MeanDitch=sum(Ditch)./max(size(aq));
    set(MeanS,'String',sprintf(['Mean Step:\n',num2str(MeanStep)]));
    set(MeanD,'String',sprintf(['Mean Ditch:\n',num2str(MeanDitch)]));
    subplot(hsub2);plot(L{k});hold on; plot(ones(size(L{k})).*HlineR(k),'r');plot(ones(size(L{k})).*HlineL(k),'black');
    plot(ones(size(L{k})).*min(L{k}),'--');hold off;
    title('Height profile along the selected region: Profile (blue), Minimum (--), Left (black) and Right (red).')
  end
  function Bound_button(hObject,eventData)
      choice = questdlg('Which method to select the boundary?', ...
        'Boundary selection method', ...
        'Microscopy Image','2D Profile','2D Profile');
    ac1=evalin('base','ac1');
    ac2=evalin('base','ac2');
    h1=evalin('base','h1');
    if  strcmp(choice,'2D Profile')==1
        boundfig=figure;imagesc(h1);title('Select the grain');colormap copper
    elseif  strcmp(choice,'Microscopy Image')==1
        boundfig=figure;imagesc(Image);title('Select the grain');colormap gray
    end
    [Grain,graindim]=imcrop;close(boundfig);
    grainfig=figure;imagesc(Grain);colormap gray
    title('Select a region around the boundary. NOTE: Cross the boundary in the second line');
    O=ginput(4); O=[O;O(1,:)];
    close(boundfig);
    
     [x1,y1,c]=improfile(Grain,O(1:2,1),O(1:2,2));
     x1=fix(x1); y1=fix(y1);
     [x2,y2,c]=improfile(Grain,O(3:4,1),O(3:4,2),length(c));
     x2=fix(x2); y2=fix(y2);

    set(Slider,'Max',length(c));    set(Slider,'SliderStep',[1/(length(c)-1) 1/(length(c)-1)]);
    GrainProf=imcrop(h1,graindim);
    
    figure(hGui);subplot(hsub1);axis equal; imagesc(Grain);colormap gray
    hold on;plot(O(:,1),O(:,2),'-','LineWidth',1.5);hold off
    figure(hGui);subplot(hsub11);axis equal; imagesc(GrainProf);colormap gray
    hold on;plot(O(:,1),O(:,2),'-','LineWidth',1.5);hold off
    
    for k=1:length(c)
        L{k}=improfile(GrainProf,[x1(k) x2(length(c)-k+1)],[y1(k) y2(length(c)-k+1)]);
        [minH,xmin]=min(L{k});
        Ll=L{k}(1:xmin);    Lr=L{k}(xmin:end);
        
        A=0;
        for i=1:length(Ll)
            A(i)=abs(trapz(Ll-Ll(i)));
        end
        save Dat.mat
        [minA,xA]=min(A);
        HlineL(k)=Ll(xA);
        
        A=0;
        for i=1:length(Lr)
            A(i)=abs(trapz(Lr-Lr(i)));
        end
        [minA,xA]=min(A);
        HlineR(k)=Lr(xA);
        
        Step(k)=abs(HlineR(k)-HlineL(k));
        Ditch(k)=max(HlineR(k),HlineL(k))-min(L{k});
    end
    Step=Step';
    Ditch=Ditch';
    MeanStep=mean(Step);    MeanDitch=mean(Ditch);
    set(MeanS,'String',sprintf(['Mean Step:\n',num2str(MeanStep)]));
    set(MeanD,'String',sprintf(['Mean Ditch:\n',num2str(MeanDitch)]));
    k=1;
    subplot(hsub1);hold on;hLPlot= plot([x1(k) x2(length(c)-k+1)],[y1(k) y2(length(c)-k+1)],'r');
    hold off;title('Selected region (red line)')
    subplot(hsub11);hold on;hLPlot11= plot([x1(k) x2(length(c)-k+1)],[y1(k) y2(length(c)-k+1)],'r');
    hold off;title('Selected region (red line)')
    subplot(hsub2);plot(L{k});hold on; plot(ones(size(L{k})).*HlineR(k),'r');plot(ones(size(L{k})).*HlineL(k),'black');
    plot(ones(size(L{k})).*min(L{k}),'--');hold off;
    title('Height profile along the selected region: Profile (blue), Minimum (--), Left (black) and Right (red).')
%     figure;mesh(h1);
  end
  function save_button(hObject,eventData)
    choicesave = questdlg('Which mode to save the data?', ...
            'Save...', ...
            'Save profile data','Save all','Save profile data');
    if  strcmp(choicesave,'Save profile data')==1
        [file,add]=uiputfile('*.mat','Save the MAT data',Add);
        save([add,file],'Step','Ditch','MeanStep','MeanDitch','L');
        saveas(hGui,[add,file(1:end-4)],'jpg')
    elseif  strcmp(choicesave,'Save all')==1
        [file,add]=uiputfile('*.mat','Save the MAT data',Add);
        save([add,file]);
        saveas(hGui,[add,file(1:end-4)],'jpg')
    end
  end
  function Slider_button(hObject,eventData)
    k = fix(get(Slider,'Value')); 
    if exist('hLPlot','var') && isa(hLPlot,'double')
        subplot(hsub1);delete(hLPlot);
    end
    if exist('hLPlot11','var') && isa(hLPlot11,'double')
        subplot(hsub11);delete(hLPlot11);
    end
    subplot(hsub1);hold on;hLPlot= plot([x1(k) x2(length(c)-k+1)],[y1(k) y2(length(c)-k+1)],'r');
    hold off;title('Selected region (red line)')
    subplot(hsub11);hold on;hLPlot11= plot([x1(k) x2(length(c)-k+1)],[y1(k) y2(length(c)-k+1)],'r');
    hold off;title('Selected region (red line)')
    subplot(hsub2);plot(L{k});hold on; plot(ones(size(L{k})).*HlineR(k),'r');plot(ones(size(L{k})).*HlineL(k),'black');
    plot(ones(size(L{k})).*min(L{k}),'--');hold off;
    title('Height profile along the selected region: Profile (blue), Minimum (--), Left (black) and Right (red).')
  end
  function close_button(hObject,eventData)
    close all;
  end
end