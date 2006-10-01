## Copyright (C) 2006 Arno Onken
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
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

## -*- texinfo -*-
## @deftypefn {Function File} {@var{y} =} raylpdf (@var{x}, @var{sigma})
## Calculates the probability density function of the Rayleigh distribution.
##
## Arguments are
##
## @itemize
## @item
## @var{x} is the support. The elements of @var{x} must be non-negative.
##
## @item
## @var{sigma} is the parameter of the Rayleigh distribution. The elements
## of @var{sigma} must be positive.
## @end itemize
## @var{x} and @var{sigma} must be of common size or one of them must be
## scalar.
##
## Return values are
##
## @itemize
## @item
## @var{y} is the probability density of the Rayleigh distribution at each
## element of @var{x} and corresponding parameter @var{sigma}.
## @end itemize
##
## Examples:
##
## @example
## x = 0:0.5:2.5;
## sigma = 1:6;
## y = raylpdf (x, sigma)
##
## y = raylpdf (x, 0.5)
## @end example
##
## References:
##
## @enumerate
## @item
## W. L. Martinez and A. R. Martinez. @cite{Computational Statistics
## Handbook with MATLAB.} Chapman & Hall/CRC, pages 547-557, 2001.
##
## @item
## Wikipedia contributors. Rayleigh distribution. @cite{Wikipedia, The Free
## Encyclopedia.}
## @uref{http://en.wikipedia.org/w/index.php?title=Rayleigh_distribution&oldid=69294908},
## August 2006.
## @end enumerate
## @end deftypefn

## Author: Arno Onken <whyly@gmx.net>
## Description: PDF of the Rayleigh distribution

function y = raylpdf (x, sigma)

  # Check arguments
  if (nargin != 2)
    usage ("y = raylpdf (x, sigma)");
  endif

  if (! isempty (x) && ! ismatrix (x))
    error ("raylpdf: x must be a numeric matrix");
  endif
  if (! isempty (sigma) && ! ismatrix (sigma))
    error ("raylpdf: sigma must be a numeric matrix");
  endif

  if (! isscalar (x) || ! isscalar (sigma))
    [retval, x, sigma] = common_size (x, sigma);
    if (retval > 0)
      error ("raylpdf: x and sigma must be of common size or scalar");
    endif
  endif

  # Calculate pdf
  y = x .* exp ((-x .^ 2) ./ (2 .* sigma .^ 2)) ./ (sigma .^ 2);

  # Continue argument check
  k = find (! (x >= 0) | ! (x < Inf) | ! (sigma > 0));
  if (any (k))
    y (k) = NaN;
  endif

endfunction

%!test
%! x = 0:0.5:2.5;
%! sigma = 1:6;
%! y = raylpdf (x, sigma);
%! expected_y = [0.0000, 0.1212, 0.1051, 0.0874, 0.0738, 0.0637];
%! assert (y, expected_y, 0.001);

%!test
%! x = 0:0.5:2.5;
%! y = raylpdf (x, 0.5);
%! expected_y = [0.0000, 1.2131, 0.5413, 0.0667, 0.0027, 0.0000];
%! assert (y, expected_y, 0.001);