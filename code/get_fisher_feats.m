% Starter code prepared by James Hays for Computer Vision

%This feature representation is described in the handout, lecture
%materials, and Szeliski chapter 14.

function image_feats = get_fisher_feats(image_paths)
% image_paths is an N x 1 cell array of strings where each string is an
% image path on the file system.

% image_feats is an N x d matrix, where d is the dimensionality of the
% feature representation. In this case, d will equal the number of clusters
% or equivalently the number of entries in each image's histogram
% ('vocab_size') below.

load('vocab_fisher_20.mat','means','covariances','priors')
for i = 1:size(image_paths,1)
  [~,features] = vl_dsift(single(imread(image_paths{i})),'norm','step',8);
  feats = vl_fisher(double(features),means,covariances,priors,'normalized');
  image_feats(i,:) = feats';
end
end