function [alf, alt, alp] = pmpalignment(spmp, avpmp, map)
% pmpalignment  - compute alignment PMPs
%
% FORMAT:       [alf, alt, alp] = pmpalignment(spmp, avpmp, mapno)
%
% Input fields:
%
%       spmp        single subject PMP object
%       avpmp       average PMP object
%       map         map number
%
% Output fields:
%
%       alf         force alignment map
%       alt         theta alignment map
%       alp         phi alignment map
%
% Note: avpmp should contain twice the number of maps with STD maps!

% Version:  v0.9a
% Build:    10051716
% Date:     May-17 2010, 10:48 AM EST
% Author:   Jochen Weber, SCAN Unit, Columbia University, NYC, NY, USA
% URL/Info: http://neuroelf.net/

% Copyright (c) 2010, Jochen Weber
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in the
%       documentation and/or other materials provided with the distribution.
%     * Neither the name of Columbia University nor the
%       names of its contributors may be used to endorse or promote products
%       derived from this software without specific prior written permission.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
% ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY
% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
% ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

% get two maps
smc = numel(spmp.Map);
sm = spmp.Map(map).PMPData;
am = avpmp.Map(map).PMPData;

% compute gradients of difference map
[alp, alt] = gradient(sm - am);
if numel(avpmp.Map) >= (3 * smc)
    alf = sqrt(1 / (2 * numel(alt))) ./ avpmp.Map(map + smc).PMPData;
else
    alf = ones(size(alp)) ./ sqrt(sqrt(2 * numel(alt)));
end
