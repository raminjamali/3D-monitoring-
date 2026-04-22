function varargout=unwrap_Goldstein(varargin)
% Matlab interface with the Phase Unwrapping Package from Dennis C. G.
% Usage: unwrap_Gold(phasefilename) or unwrap_Gold(phasedata)
% phasedata should within [0,2pi] or [-pi,pi] if it is double, or
% within range [0,255] if of class uint8 

% Written by Fucai, 19/04/2005, ITO
% revision 22/04/2005, apply filter to whole phase map

warning('off');
switch nargin
    case 2
        if any(abs(varargin{:})>1)
            error('real and imagary parts cannot have absolute values larger than one')
            return;
        end
        imReal=double(varargin{1});
        imImag=double(varargin{2});
        phase=atan2(imImag,imReal)+pi;
    case 1
        if isstr(varargin{1})
            [phase,map]=imread(varargin{1});
            if isind(phase) && ~isempty(map), 
                phase=ind2gray(phase,map); 
            end
            if isrgb(phase), phase=rgb2gray(phase); end
            if isa(phase,'uint8'), phase=double(phase)/255*2*pi;end
        else
            phase=varargin{1};
            if isa(phase,'uint8'), phase=double(phase)/255*2*pi;end
            if any(phase<0), phase=phase+pi;end
            if any(phase(:)>2*pi) || any(phase(:)<0)
                disp('phase must be within range [0,2pi]');
                return;
            end
        end
    otherwise
        disp('bad arguments \n Usages: fnPURP(phasefilename) or fnPURP(phasedata)');
end
% mask definition
finished=1;
mask=uint8(ones(size(phase)));
phase=double(phase);
% disp('Please define Regions of Interest (ROI) ');


while ~finished
    satisfied=0;
    while ~satisfied
        imshow(phase,[]);
        boundary=edge(mask);
        [x,y]=find(boundary>0);
        hold on; plot(y,x,'.r','markersize',4);         
        [c,r]=getlinec('closed');
        bw=roipolyc(phase,c,r);
        boundary=edge(double(mask | bw));
        [x,y]=find(boundary>0);
        hold on; plot(y,x,'.r','markersize',4); hold off;
        button = questdlg('Are you satisfied with this selection?');
        if strcmp(button,'Cancel')==3, break; end
        if strcmp(button,'Yes'), 
            satisfied=1;
            mask=mask | bw;
        end
    end
    button = questdlg('Do you want to define other ROI?');
    if strcmp(button,'Cancel')==3, return; end
    if strcmp(button,'No'), finished=1;end
end
% phasemasked=phase.*double(mask);

% % filtering
% FilterType={  'average [3 3]'   % averaging filter
%     'average [5 5]'   % averaging filter
%     'average [7 7]'   % averaging filter
%     'average [9 9]'   % averaging filter
%     'disk 5'      % circular averaging filter
%     'disk 7'      % circular averaging filter
%     'disk 9'      % circular averaging filter
%     'gaussian [3 3],0.5'  % Gaussian lowpass filter: HSIZE,SIGMA
%     'gaussian [5 5],0.5'  % Gaussian lowpass filter: HSIZE,SIGMA
%     'gaussian [7 7],0.5'  % Gaussian lowpass filter: HSIZE,SIGMA
%     'gaussian [9 9],0.5'  % Gaussian lowpass filter: HSIZE,SIGMA
%     'gaussian [3 3],0.3'  % Gaussian lowpass filter: HSIZE,SIGMA
%     'gaussian [3 3],0.7'  % Gaussian lowpass filter: HSIZE,SIGMA
%     };
% 
% button = questdlg('Do you want to filter the phase map?');
% switch button
%     case 'Yes'
%         satisfied = 0;
%         while ~satisfied
%             filtertype=menu('Please choose the filter type', FilterType);
%             switch(filtertype)
%                 case 1
%                     B=fspecial('average',[3,3]);
%                 case 2
%                     B=fspecial('average',[5,5]);
%                 case 3
%                     B=fspecial('average',[7,7]);
%                 case 4
%                     B=fspecial('average',[9,9]);
%                 case 5
%                     B=fspecial('disk',5);
%                 case 6
%                     B = fspecial('disk',7);
%                 case 7
%                     B = fspecial('disk',9);
%                 case 8
%                     B = fspecial('gaussian', [3, 3],0.5);
%                 case 9
%                     B = fspecial('gaussian', [5, 5],0.5);
%                 case 10
%                     B = fspecial('gaussian', [7, 7],0.5);
%                 case 11
%                     B = fspecial('gaussian', [9, 9],0.5);
%                 case 12
%                     B = fspecial('gaussian', [3, 3],0.3);
%                 case 13
%                     B = fspecial('gaussian', [3, 3],0.7);
%             end
% 
%             Real = filter2(B,cos(phase),'same');
%             Imag = filter2(B,sin(phase),'same');
%             phasenew = atan2(Imag, Real);
%             imshow(phasenew.*double(mask),[]);
%             button1 = questdlg('Are you satisfied with the filtered image?');
%             if strcmp(button1,'Cancel')==3, 
%                 button='Cancel'; 
%                 break; 
%             end
%             if strcmp(button1,'Yes'), satisfied=1;end
%         end
%         phasefiltered=phasenew;
%         clear phasenew Real Imag
%     case 'Cancel'
%         disp('The phase unwrap operation has been canceled');
%         return;
%     case 'No'
%         phasefiltered=phase;
% end

% unwrapping

phase=single(phase);
phasefilename = tempname;
fid=fopen(phasefilename,'wb');
fwrite(fid,phase,'float32');
fclose(fid);

mask=uint8(mask*255);
maskfilename = tempname;
fid=fopen(maskfilename,'wb');
fwrite(fid,mask,'uint8');
fclose(fid);

[m,n]=size(phase);

unwrappedfilename = tempname;
eval(['!unphs6 -input ', phasefilename, ' -output ', ...
    unwrappedfilename, ' -format float -xsize ',num2str(m),' -ysize ', num2str(n)]) ;
fid = fopen(unwrappedfilename, 'rb');
unphase=fread(fid, [m, n],'float32', 'l');
fclose(fid);
delete(fullfile(tempdir,phasefilename));
delete(fullfile(tempdir,maskfilename));
delete(fullfile(tempdir,unwrappedfilename));

% % show results
% figure;
% imshow(unphase.*(mask>1),[]);
% figure;
 M=unphase.*(mask>1);
 save unwrap M
 %mesh(unphase.*(mask>1)); axis on;

if nargout ==1, varargout{1}=unphase; end
