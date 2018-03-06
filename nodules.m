files = dir('*Y2000*');
nodule_slices = [];
slice_tot =[];
points = [];
for i = 1: length(files)
mask = dicomread(files(i).name);
mask = squeeze(mask);
[x,y,z] = ind2sub(size(mask),find(mask));%For finding non zero elements of 3d arrays
%disp(mat2str([unique(z)]))
points = [points;numel([x,y,z])];
disp(numel([x,y,z]));
slice_tot = [slice_tot;length(mask(1,1,:))];
%nodule_slices = [nodule_slices;mat2str([unique(z)])];
%disp(nodule_slices)
end


%%

mask = dicomread('1034_Y19990102.dcm');
mask = squeeze(mask);
[x,y,z] = ind2sub(size(mask),find(mask));%For finding non zero elements of 3d arrays
scatter3(x,y,z)
%%

img = dicomread('D:\Yale_Course\ISBI\Challenge3\ISBI-deid-TRAIN-DICOM\ISBI-deid-TRAIN\1034\19990102\anno_9.dcm');
imshow(imadjust(img))
%%
directory = uigetdir();
files = dir(fullfile(directory, '*.dcm'));
filenames = cellfun(@(x)fullfile(directory, x), {files.name}, 'uni', 0);

%// Ensure that they are actually DICOM files and remove the ones that aren't
notdicom = ~cellfun(@isdicom, filenames);
files(notdicom) = [];

%// Now load all the DICOM headers into an array of structs
infos = cellfun(@dicominfo, filenames);

%// Now sort these by the instance number
[~, inds] = sort([infos.InstanceNumber]);
infos = infos(inds);

%// Now you can loop through and display them
dcm = dicomread(infos(1));
him = imshow(dcm, []);

% for k = 1:numel(infos)
%     set(him, 'CData', dicomread(infos(k)));
%     pause(0.1)
% end
%% For all slices
mask1 = niftiread('1007_Y20000102.nii');
mask2 = niftiread('1007_Y19990102.nii');

directory1 = 'D:\Yale_Course\ISBI\Challenge3\ISBI-deid-TRAIN-DICOM\ISBI-deid-TRAIN\1007\19990102\';
directory2 = 'D:\Yale_Course\ISBI\Challenge3\ISBI-deid-TRAIN-DICOM\ISBI-deid-TRAIN\1007\20000102\';
files1 = dir(fullfile(directory1, '*.dcm'));
files2 = dir(fullfile(directory2, '*.dcm'));
filenames1 = cellfun(@(x)fullfile(directory1, x), {files1.name}, 'uni', 0);
filenames2 = cellfun(@(x)fullfile(directory2, x), {files2.name}, 'uni', 0);
infos1 = cellfun(@dicominfo, filenames1);
infos2 = cellfun(@dicominfo, filenames2);
[~, inds1] = sort([infos1.InstanceNumber]);
infos1 = infos1(inds1);
[~, inds2] = sort([infos2.InstanceNumber]);
infos2 = infos2(inds2);

dcm1 = dicomread(infos1(1));
dcm2 = dicomread(infos2(1));

subplot(2,2,1)
him1 = imshow(dcm1, []);
subplot(2,2,2)
him2 = imshow(dcm2, []);

masked1 = double(dicomread(infos1(1))).*double(mask1(:,:,1));
masked2 = double(dicomread(infos2(1))).*double(mask2(:,:,1));

subplot(2,2,3)
him_mask1 = imshow(masked1, []);

subplot(2,2,4)
him_mask2 = imshow(masked2, []);


%him2 = imshow(dcm,[]);
for i = 1:numel(infos)
    mask_cur1 = imrotate(int16(mask1(:,:,i)), 180);
    mask_cur2 = imrotate(int16(mask2(:,:,i)), 180);
    set(him1, 'CData', dicomread(infos1(i)));
    masked1 = double(dicomread(infos1(i))).*double(mask_cur1);
    set(him_mask1, 'CData', masked1);
    
    set(him2, 'CData', dicomread(infos2(i)));
    masked2 = int16(dicomread(infos2(i))).*int16(mask_cur2);
    set(him_mask2, 'CData', masked2);
    
    %set(him2, 'CData',uint8(dicomread(infos(i))));
    title(i);
    pause(0.5)
end

%% 
directory1 = 'D:\Yale_Course\ISBI\Challenge3\ISBI-deid-TRAIN-DICOM\ISBI-deid-TRAIN\1001\19990102\';
mask1 = niftiread('1001_Y20000102.nii');
files1 = dir(fullfile(directory1, '*.dcm'));
filenames1 = cellfun(@(x)fullfile(directory1, x), {files1.name}, 'uni', 0);
infos1 = cellfun(@dicominfo, filenames1);
[~, inds1] = sort([infos1.InstanceNumber]);
infos1 = infos1(inds1);



mask1 = squeeze(mask1);

masked1 = double(dicomread(infos1(1))).*double(mask1(:,:,1));
[x,y,z] = ind2sub(size(mask1),find(mask1));%For finding non zero elements of 3d arrays
slices = (unique(z));
dcm1= dicomread(infos1(1));
subplot(2,1,1)
him1 = imshow(dcm1, []);
subplot(2,1,2)
him_mask1 = imshow(masked1, []);

for i = 1:numel(slices)
    %figure;
    title(slices(i));
    mask = imrotate(int16(mask1(:,:,slices(i))), 180);
    masked = int16(dicomread(infos1(slices(i)))).*mask;
    set(him1, 'CData', dicomread(infos1(slices(i))));
    set(him_mask1, 'CData', masked);
    %imshow(masked)
    %set(him2, 'CData',uint8(dicomread(infos(i))));
    pause(2)
    
end


%% For nodule slices
directory = 'D:\Yale_Course\ISBI\Challenge3\ISBI-deid-TRAIN-DICOM\ISBI-deid-TRAIN\1031\20000102\';
mask = dicomread('1031_Y20000102.dcm');
files = dir(fullfile(directory, '*.dcm'));
filenames = cellfun(@(x)fullfile(directory, x), {files.name}, 'uni', 0);


%// Ensure that they are actually DICOM files and remove the ones that aren't
notdicom = ~cellfun(@isdicom, filenames);
files(notdicom) = [];

%// Now load all the DICOM headers into an array of structs
infos = cellfun(@dicominfo, filenames);

%// Now sort these by the instance number
[~, inds] = sort([infos.InstanceNumber]);
infos1 = infos(inds);

dcm = dicomread(infos1(1));
subplot(2,1,1)
him = imshow(dcm, []);
set(him, 'CData', dcm);
subplot(2,1,2)
imshow(mask,[])
set(him2, 'CData', dcm);

for i = 1:numel(slices)
    %figure;
    title(slices(i));
    masked = int16(dicomread(infos(slices(i)))).*int16(mask(:,:,slices(i)));
    set(him, 'CData', dcm);
    set(him2, 'CData', masked);
    %imshow(masked)
    %set(him2, 'CData',uint8(dicomread(infos(i))));
    pause(0.5)
    
end



%% For masking
img = dicomread('D:\Yale_Course\ISBI\Challenge3\ISBI-deid-TRAIN-DICOM\ISBI-deid-TRAIN\1034\19990102\anno_9.dcm');

% for i = 1:size(mask,3)
%     mask(:,:,i) = imrotate(mask(:,:,i),90);
% end
mask = squeeze(mask);
[x,y,z] = ind2sub(size(mask),find(mask));%For finding non zero elements of 3d arrays
disp(unique(z))

%masked = im2double(img).*im2double((mask(:,:,99)));
%[x,y] = find(masked);
x = 512-1;
y = 512 -y;
[indsx,indsy] = find(mask(:,:,100));
imshow(imadjust(img))
hold on

scatter(indsx, indsy)
scatter(500-indsx, 500-indsy)
figure
scatter3d(x,y,z)