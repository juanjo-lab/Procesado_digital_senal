function [y] = ecualizador(B1,A1,B2,A2,B3,A3,G1,G2,G3,x)
y1 = (10^(G1/20))*filter(B1,A1,x);
y2 = (10^(G2/20))*filter(B2,A2,x);
y3 = (10^(G3/20))*filter(B3,A3,x);
y=y1+y2+y3;

end