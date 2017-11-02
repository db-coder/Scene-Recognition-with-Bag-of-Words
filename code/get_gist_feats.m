% Starter code prepared by James Hays for Computer Vision

%This feature representation is described in the handout, lecture
%materials, and Szeliski chapter 14.

function image_feats = get_gist_feats(image_paths)
% image_paths is an N x 1 cell array of strings where each string is an
% image path on the file system.

% image_feats is an N x d matrix, where d is the dimensionality of the
% feature representation. In this case, d will equal the number of clusters
% or equivalently the number of entries in each image's histogram
% ('vocab_size') below.

clear param
for i = 1:size(image_paths,1)
  im = single(imread(image_paths{i}));
  param.imageSize = [256 256];
  param.orientationsPerScale = [8 8 8 8];
  param.numberBlocks = 4;
  param.fc_prefilt = 4;
  image_feats(i,:) = LMgist(im,'',param);
  image_feats(i,:) = image_feats(i,:)/sum(image_feats(i,:));
end
end