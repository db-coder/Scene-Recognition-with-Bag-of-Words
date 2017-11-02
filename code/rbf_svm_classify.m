% Starter code prepared by James Hays for Computer Vision

function predicted_categories = rbf_svm_classify(train_image_feats, train_labels, test_image_feats)
% image_feats is an N x d matrix, where d is the dimensionality of the
%  feature representation.
% train_labels is an N x 1 cell array, where each entry is a string
%  indicating the ground truth category for each training image.
% test_image_feats is an M x d matrix, where d is the dimensionality of the
%  feature representation. You can assume M = N unless you've modified the
%  starter code.
% predicted_categories is an M x 1 cell array, where each entry is a string
%  indicating the predicted category for each test image.

%unique() is used to get the category list from the observed training
%category list. 'categories' will not be in the same order as in proj4.m,
%because unique() sorts them. This shouldn't really matter, though.
categories = unique(train_labels); 
num_categories = length(categories);
predicted_categories = cell(size(test_image_feats,1),1);
for i = 1:num_categories
  matching_indices = strcmp(categories{i},train_labels);
  matching_indices = double(matching_indices);
  matching_indices(find(~matching_indices)) = -1;
  svm_train_labels = double(matching_indices);
  svm_model{i} = fitcsvm(double(train_image_feats),svm_train_labels,'KernelFunction','rbf');
end
for i = 1:num_categories
  [~,scores] = predict(svm_model{i},test_image_feats);
  confidence(i,:) = (scores(:,2))';
end
[~,index] = max(confidence);
for i = 1:size(test_image_feats,1)
  predicted_categories{i,1} = categories{index(i)};
end
end