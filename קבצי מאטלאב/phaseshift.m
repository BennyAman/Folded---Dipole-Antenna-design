function ps = phaseshift(f,d,ang,N)
%PHASESHIFT is used to calculate the phaseshift values for an array
% PS = PHASESHIFT(F,D,ANG,N), returns set of phaseshift values to be
% applied to an array in order to scan the beam. The default phaseshift
% values are calculated for an N element linear array operating at a
% frequency F, with an element spacing d, and to be scanned to an angle
% ANG. The velocity of light is assumed to be that of free space.

% The PHASESHIFT function is used for an internal example.
% Its behavior may change in subsequent releases, so it should not be
% relied upon for programming purposes.

% Copyright 2014 The MathWorks, Inc.

% Check attributes
validateattributes(f,{'numeric'},{'scalar','nonempty','real',     ...
    'finite','nonnan','positive',   ...
    'nonzero'});
validateattributes(d,{'numeric'},{'nonempty','real',     ...
    'finite','nonnan','positive',   ...
    'nonzero'});
validateattributes(ang,{'numeric'},{'numel',2,'nonempty','real','finite','nonnan'});
validateattributes(N,{'numeric'},...
    {'nonempty','integer','finite','nonnan','positive'});

if isscalar(d)
    arraytype = 'linear';
elseif isequal(numel(d),2)
    arraytype = 'rectangular';
else
    error(message('antenna:antennaerrors:InvalidValue','spacing',       ...
                    'a scalar for linear arrays or a 2 element vector for rectangular arrays rather',...
                    ['having ' num2str(numel(d)) ' elements']));
                
end
phasevelocity = 2.99792458e8;
scanangle = ang.*pi/180;
k   = 2*pi*f/phasevelocity;

if strcmpi(arraytype,'linear')
    delta_ps  = -1*k*d*cos(scanangle(1));
    ps =(0:N-1).*delta_ps;
elseif strcmpi(arraytype,'rectangular')
    delta_pscol = -1*k*d(1)*sin(pi/2 - scanangle(2))*cos(scanangle(1));
    delta_psrow = 1*k*d(2)*sin(pi/2 - scanangle(2))*sin(scanangle(1));
    pscol = (0:N(2)-1).*delta_pscol;
    psrow = (0:N(1)-1).*delta_psrow;
    
    [PSCOL,PSROW] = meshgrid(pscol,psrow);
    ps = PSCOL + PSROW;
end

% Convert to degrees
ps = mod(ps.*180/pi,360);
end
