signal = 1101110010
zPol = 1011

function[podiel, zvysok]= delenie(signal, zPol)

% Funkcia na delenie polynomov s koeficientami 0 alebo 1
% Argumenty:
%   signal - vektor pozostavajuci z 0 a 1
%   zPol - vektor pozostavajuci z 0 a 1
% 	(ireducibilny polynom)
% 
% Navratove hodnoty:
%   podiel - vektor 0 a 1 reprezentujuci podiel
%   zvysok - zvysok po deleni zPol ako vektor z 0 a 1

pocetVyslednychCislic = length(signal) - length(zPol)
podiel = zeros(1, pocetVyslednychCislic)
zvysok = zeros(1, length(zPol) - 1)