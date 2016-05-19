file = 'C:\Users\etumang.MILKYWAY\Desktop\sdrsharp\N18_4827.wav';

hold on
[d, rate] = wavread(file);

tester = abs(d);
%plot(tester,'g')
[B,A] = butter(9,1000/(rate/2),'low');%filter out carrier
dc = mean(tester);%get DC offset

smooth = filter(B,A,tester);
%plot(smooth,'b')

clean = smooth - dc;

t=[0:1/rate:1/160];%make the synchronization wave
cr=(square(1040*t*(2*pi)));

%cross-correlate to find the beginning of each row
sim = xcorr(cr,clean);
sim = sim (1:length(clean));


%figure out the # of rows; %division by 2 is becuase there are actually 2
%image types in there, with different start points
rows = floor(length(sim)*2/rate);
%get the samples/row
row_len = floor(rate/2);
pixel_len = ceil(rate/2);

%break data into rows
for n = 1:rows
    [v,i]=max(sim((n-1)*row_len+1:n*row_len));
    list(n)=i+row_len*n;
end
%the other group did a lot of correction code here that i did not implement

for n = 1:rows-2%i don't know why this happens, it seems like
    raw(n,1:pixel_len) = clean(list(n):list(n)+pixel_len-1);
end

%display it
figure(1)
imagesc(raw);
axis image;
colormap(gray);

%plot(clean, 'r')
hold off
