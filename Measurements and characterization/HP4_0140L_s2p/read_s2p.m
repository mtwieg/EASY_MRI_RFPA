function [f,S] = read_s2p(filename)
% filename = 'S2P_J26SHORT_0X0000.s2p';
numberOfHeaderLines = 5;
FID = fopen(filename);
datacell = textscan(FID,'%f%f%f%f%f%f%f%f%f','Headerlines',numberOfHeaderLines,'CollectOutput',1);
fclose(FID);
A=datacell{1};
[a b]=size(A);
f=squeeze(A(:,1));

S=zeros(a,2,2);
S(:,1,1)=A(:,2)+1i*A(:,3);
S(:,2,1)=A(:,4)+1i*A(:,5);
S(:,1,2)=A(:,6)+1i*A(:,7);
S(:,2,2)=A(:,8)+1i*A(:,9);
end

