function drawPapPnt(MapFig, Lmk, color, MapOpt)

% DRAWPAPPNT  Draw parallax angle parametrization point landmark in MapFig.

%   Copyright 2015 Ellon Paiva @ LAAS-CNRS.

global Map

posOffset = [0;0;.2];

% transform to Euclidean
switch Map.type
    case 'ekf'
        [x,P] = propagateUncertainty(       ...
            Map.x(Lmk.state.r),             ...
            Map.P(Lmk.state.r,Lmk.state.r), ...
            @pap2euc);
    case 'graph'
        x = pap2euc(Lmk.state.x);
%         P = eye(3); % irrelevant because we will not print ellipses
end

% draw
drawPnt(MapFig.Lmk(Lmk.lmk).mean, x, color.mean)
if MapOpt.showEllip
    drawEllipse(MapFig.Lmk(Lmk.lmk).ellipse, x, P, color.ellip)
end
if MapOpt.showLmkId
    drawLabel(MapFig.Lmk(Lmk.lmk).label,   x+posOffset, num2str(Lmk.id))
end
if MapOpt.showAncLink 
    ma = Lmk.state.x(1:3);
    drawSeg(MapFig.Lmk(Lmk.lmk).mainlink,[x;ma],MapOpt.colors.mainLink);
    if numel(Lmk.state.x) > 5
        aa = Lmk.state.x(4:6);
        drawSeg(MapFig.Lmk(Lmk.lmk).assolink,[x;aa],MapOpt.colors.assoLink);
    end
end


% ========== End of function - Start GPL license ==========


%   # START GPL LICENSE

%---------------------------------------------------------------------
%
%   This file is part of SLAMTB, a SLAM toolbox for Matlab.
%
%   SLAMTB is free software: you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
%
%   SLAMTB is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You should have received a copy of the GNU General Public License
%   along with SLAMTB.  If not, see <http://www.gnu.org/licenses/>.
%
%---------------------------------------------------------------------

%   SLAMTB is Copyright:
%   Copyright (c) 2008-2010, Joan Sola @ LAAS-CNRS,
%   Copyright (c) 2010-2013, Joan Sola,
%   Copyright (c) 2014-2015, Joan Sola @ IRI-UPC-CSIC,
%   SLAMTB is Copyright 2009 
%   by Joan Sola, Teresa Vidal-Calleja, David Marquez and Jean Marie Codol
%   @ LAAS-CNRS.
%   See on top of this file for its particular copyright.

%   # END GPL LICENSE

