function varargout = randraw(distribName, distribParams, varargin)

funcName = mfilename;

distribNameInner = lower( distribName( ~isspace( distribName ) ) );


if length(sampleSize) == 1
     sampleSize = [ sampleSize, 1 ];
end

if strcmp(runMode, 'genRun')
     runExample = 0;
     plotFlag = 0;

     dbclear if warning;
     out = [];
     if prod(sampleSize) > 0
          switch lower( distribNameInner )
             
                    
               case {'erlang'}
                    % START erlang HELP
                    % THE ERLANG DISTRIBUTION
                    %
                    %  pdf = (y/a).^(n-1) .* exp( -y/a ) / (a*gamma(n));
                    %  cdf = gammainc( n, y/sacle );
                    %
                    %   Mean = a*n;
                    %   Variance = a^2*n;
                    %   Skewness = 2/sqrt(n);
                    %   Kurtosis = 6/n;
                    %   Mode = (a<1)*0 + (a>=1)*a*(n-1);
                    %
                    %  PARAMETERS:
                    %    a - scale parameter (a>0)
                    %    n - shape parameter (n = 1, 2, 3, ...)
                    %
                    %  SUPPORT:
                    %    y,  y >= 0
                    %
                    %  CLASS:
                    %    Continuous skewed distributions
                    %
                    %  NOTES:
                    %    The Erlang distribution is a special case of the gamma distribution where 
                    %    the shape parameter is an integer
                    %
                    % USAGE:
                    %   randraw('erlang', [a, n], sampleSize) - generate sampleSize number
                    %         of variates from the Erlang distribution
                    %         with scale parameter 'a' and shape parameter 'n';
                    %   randraw('erlang') - help for the Erlang distribution;
                    %
                    % EXAMPLES:
                    %  1.   y = randraw('erlang', [1, 3], [1 1e5]);
                    %  2.   y = randraw('erlang', [0.5, 5], 1, 1e5);
                    %  3.   y = randraw('erlang', [10, 6], 1e5 );
                    %  4.   y = randraw('erlang', [7, 4], [1e5 1] );
                    %  5.   randraw('erlang');     
                    %
                    % SEE ALSO:
                    %   GAMMA distribution
                    % END erlang HELP
                    
                    %
                    % Inverse CDF transformation method.
                    %
                   
                    checkParamsNum(funcName, 'Erlang', 'erlang', distribParams, [2]);
                    a = distribParams(1);
                    n = distribParams(2);                    
                    validateParam(funcName, 'Erlang', 'erlang', '[a, n]', 'a', a, {'> 0'});
                    validateParam(funcName, 'Erlang', 'erlang', '[a, n]', 'n', n, {'> 0', '==integer'});
                    
                    out = feval(funcName, 'gamma', n, sampleSize);
                    out = a * out;
                    
              
             
               otherwise
                    fprintf('\n RANDRAW: Unknown distribution name: %s \n', distribName);
                    
          end % switch lower( distribNameInner )
          
     end % if prod(sampleSize)>0

     varargout{1} = out;

     return;

end % if strcmp(runMode, 'genRun')

return;
function checkParamsNum(funcName, distribName, runDistribName, distribParams, correctNum)
if ~any( numel(distribParams) == correctNum )
     error('%s Variates Generation:\n %s%s%s%s%s', ...
          distribName, ...
          'Wrong numebr of parameters (run ',...
          funcName, ...
          '(''', ...
          runDistribName, ...
          ''') for help) ');
end
return;
function validateParam(funcName, distribName, runDistribName, distribParamsName, paramName, param, conditionStr)
condLogical = 1;
eqCondStr = [];
for nn = 1:length(conditionStr)
     if nn==1
          eqCondStr = [eqCondStr conditionStr{nn}];
     else
          eqCondStr = [eqCondStr ' and ' conditionStr{nn}];          
     end
     eqCond = conditionStr{nn}(1:2);
     eqCond = eqCond(~isspace(eqCond));
     switch eqCond
          case{'<'}
               condLogical = condLogical & (param<str2num(conditionStr{nn}(3:end)));
          case{'<='}
               condLogical = condLogical & (param<=str2num(conditionStr{nn}(3:end)));               
          case{'>'}
               condLogical = condLogical & (param>str2num(conditionStr{nn}(3:end))); 
          case{'>='}
               condLogical = condLogical & (param>=str2num(conditionStr{nn}(3:end)));
          case{'~='}
               condLogical = condLogical & (param~=str2num(conditionStr{nn}(3:end)));
          case{'=='}
               if strcmp(conditionStr{nn}(3:end),'integer')
                    condLogical = condLogical & (param==floor(param));                    
               else
                    condLogical = condLogical & (param==str2num(conditionStr{nn}(3:end)));
               end
     end
end

if ~condLogical
     error('%s Variates Generation: %s(''%s'',%s, SampleSize);\n Parameter %s should be %s\n (run %s(''%s'') for help)', ...
          distribName, ...
          funcName, ...
          runDistribName, ...
          distribParamsName, ...
          paramName, ...
          eqCondStr, ...
          funcName, ...
          runDistribName);
end
return;
function cdf = normcdf(y)
cdf = 0.5*(1+erf(y/sqrt(2)));
return;
function pdf = normpdf(y)
pdf = 1/sqrt(2*pi) * exp(-1/2*y.^2);
return;
function cdfinv = norminv(y)
cdfinv = sqrt(2) * erfinv(2*y - 1);
return;
function out = randFrom5Tbls( P, offset, sampleSize)
sizeP = length(P);

if sizeP == 0
     out = [];
     return;
end

a = mod(floor([0 P]/16777216), 64);
na = cumsum( a );
b = mod(floor([0 P]/262144), 64);
nb = cumsum( b );
c = mod(floor([0 P]/4096), 64);
nc = cumsum( c );
d = mod(floor([0 P]/64), 64);
nd = cumsum( d );
e =  mod([0 P], 64);
ne = cumsum( e );

AA = zeros(1, na(end));
BB = zeros(1, nb(end));
CC = zeros(1, nc(end));
DD = zeros(1, nd(end));
EE = zeros(1, ne(end));

t1 = na(end)*16777216;
t2 = t1 + nb(end)*262144;
t3 = t2 + nc(end)*4096;
t4 = t3 + nd(end)*64;

k = (1:sizeP)+offset-1;
for ii = 1:sizeP
     AA(na(ii)+(0:a(ii+1))+1) = k(ii);
     BB(nb(ii)+(0:b(ii+1))+1) = k(ii);
     CC(nc(ii)+(0:c(ii+1))+1) = k(ii);
     DD(nd(ii)+(0:d(ii+1))+1) = k(ii);
     EE(ne(ii)+(0:e(ii+1))+1) = k(ii);
end

%jj = round(1073741823*rand(sampleSize));
jj = round(min(sum(P),1073741823) *rand(sampleSize));
out = zeros(sampleSize);
N = prod(sampleSize);
for ii = 1:N
     if jj(ii) < t1
          out(ii) = AA( floor(jj(ii)/16777216)+1 );
     elseif jj(ii) < t2
          out(ii) = BB(floor((jj(ii)-t1)/262144)+1);
     elseif jj(ii) < t3
          out(ii) = CC(floor((jj(ii)-t2)/4096)+1);
     elseif jj(ii) < t4
          out(ii) = DD(floor((jj(ii)-t3)/64)+1);
     else
          out(ii) = EE(floor(jj(ii)-t4) + 1);
     end
end

return;