% function y = isind(x)
% %ISIND Return true for indexed image.
% %   ISIND has been removed.
% 
% %   Copyright 1993-2011 The MathWorks, Inc.
% %   $Revision: 5.20.4.7 $  $Date: 2011/07/19 23:54:10 $
% 
% error(message('images:removed:functionNoReplacement','ISIND'))

% Downloaded
function y = isind(x)
%ISIND Return true for indexed image.
%   FLAG = ISIND(A) returns 1 if A is an indexed image and 0
%   otherwise. 
%
%   ISIND uses these criteria to determine if A is an indexed
%   image:
%
%   - If A is of class double, all values in A must be integers
%     greater than or equal to 1, and the number of dimensions of
%     A must be 2.
%
%   - If A is of class uint8 or uint16, the number of dimensions
%     of A must be 2.
% 
%   Note that a four-dimensional array that contains multiple
%   indexed images returns 0, not 1.
%
%   Class Support
%   -------------
%   A can be of class uint8, uint16, or double.
%
%   See also ISBW, ISGRAY, ISRGB.

%   Copyright 1993-2002 The MathWorks, Inc.  
%   $Revision: 5.20 $  $Date: 2002/03/15 15:28:32 $


y = (ndims(x)==2) & ~isempty(x);       % Check number of dimensions
if (isa(x, 'uint8') | isa(x, 'uint16')) & y
    %nothing needed
elseif isa(x, 'logical') & y
    y = 0;
elseif y   % The image is double and ndims==2
   % At first just test a small chunk to get a possible quick negative
   [m,n] = size(x);
   chunk = x(1:min(m,10),1:min(n,10));         
   y = min(chunk(:))>=1 & all((chunk(:)-floor(chunk(:)))==0);
   % If the chunk is an indexed image, test the whole image
   if y
      y = min(x(:))>=1 & all((x(:)-floor(x(:)))==0);
   end
end   

y = logical(y);

