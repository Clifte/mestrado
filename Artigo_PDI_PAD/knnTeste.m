training = [mvnrnd([ 1  1],    eye(2), 100); ...
                  mvnrnd([-1 -1],  2*eye(2), 100)];
              
group = [repmat(1,100,1); repmat(2,100,1)];

gscatter(training(:,1),training(:,2),group,'rb','+x');

legend('Training group 1', 'Training group 2');
hold on;


sample = unifrnd(-5, 5, 100, 2);
% Classify the sample using the nearest neighbor classification

c = knnclassify(sample, training, group);
gscatter(sample(:,1),sample(:,2),c,'mc'); hold on;
legend('Training group 1','Training group 2', ...
       'Data in group 1','Data in group 2');
hold off; 



gscatter(training(:,1),training(:,2),group,'rb','+x');
hold on;
c3 = knnclassify(sample, training, group, 3);
gscatter(sample(:,1),sample(:,2),c3,'mc','o');
legend('Training group 1','Training group 2','Data in group 1','Data in group 2');