function cross = crossChanCorr(c)

[numChan, nFrame, maxDelay] = size(c);
cross = zeros(numChan,nFrame);

fprintf('Getting cross-channel correlation...\n');
for tf = 1:nFrame
    acf = reshape(c(:,tf,:),numChan,maxDelay);
    acfM = mean(acf,2);
    acfVar = var(acf,0,2);    
    acfNorm = (acf-acfM*ones(1,maxDelay))./(sqrt(acfVar)*ones(1,maxDelay));  % normalize to zero mean and unit variance    
    cross(1:end-1,tf) = sum(acfNorm(2:end,:).*acfNorm(1:end-1,:),2)/maxDelay;
    cross(end,tf) = cross(end-1,tf);
end