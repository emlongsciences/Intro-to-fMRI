V = spm_vol('epi.nii');
xdim = V(1).dim(1); ydim = V(1).dim(2); zdim = V(1).dim(3);
[Y,XYZ] = spm_read_vols(V(1));
figure; plot(Y(:))
figure; imagesc(Y(:,:,15))
colormap('gray')
figure;
for z = 1:zdim
    imagesc(Y(:,:,z));
    colormap('gray');
    pause(0.2);
end
figure; plot(Y(:))
idx = sub2ind(size(Y),32,32,15);
XYZ(:,idx)
d = sqrt(sum(XYZ.^2));
[m,minIdx] = min(d);
XYZ(:,minIdx)
[voxX,voxY,voxZ] = ind2sub(size(Y),minIdx);
%33,31,2
figure; imagesc(Y(:,:,2))
V(1).mat
orig = [0; 0; 0];
tmp = V(1).mat \ [orig; 1];
voxOrig = round(tmp(1:3));
tmp = V(1).mat * [32; 32; 15; 1];
voxXYZ = tmp(1:3);
ts = spm_get_data(V,[42; 27; 22]);
figure; plot(ts)
dts = detrend(ts);
figure; plot(dts)
xy = combvec(1:xdim,1:ydim);
z = repmat(22,1,size(xy,2));
xyz = [xy; z];
voxData = spm_get_data(V,xyz);
dvoxData = detrend(voxData);
r = corr(dts,dvoxData);
funcConn = reshape(r,xdim,ydim);
figure; subplot(1,2,1); imagesc(Y(:,:,22)); colormap('gray');
subplot(1,2,2); imagesc(funcConn,[0.3 1]);
