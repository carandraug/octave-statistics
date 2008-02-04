## Copyright (C) 2001 Paul Kienzle
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; If not, see <http://www.gnu.org/licenses/>.

## A = prctile(X,p)
##
## Computes the value associated with the p-th percentile of X.  If X is
## a matrix, computes p for each column of X.  If p is a vector, the
## returned value is a matrix with one row for each element of p and one
## column for each column of X.
##
## The first and last values are pegged at 0 percent and 100 percent
## respectively, and the rest of the values are uniformly spaced between
## them, with linear interpolation between the points.  This is
## consistent with the definition of quantile given in the R statistics
## package, but inconsistent with that of the statistics toolbox from
## Matlab.
function a = prctile(x, p)
  if nargin != 2
    usage("a = prctile(x,p)");
  endif
  y = sort(x);
  if size (y,1) == 1, y = y(:); endif
  trim = 1 + (size(y,1)-1)*p(:)*0.01;
  delta = (trim - floor(trim))*ones(1,size(y,2));
  a = y(floor(trim), :) .* (1-delta) + y(ceil(trim), :) .* delta;
endfunction

%!assert(prctile([0,1],[25,75]),[.25;.75],eps)
%!assert(prctile([0,0;1,2],[25,75]),[.25,.5;.75,1.5],eps)
