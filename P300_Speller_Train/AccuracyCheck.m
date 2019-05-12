target = [];
nonTarget = [];
count = 0;
totalCount = 0;
finalVector = [];
for i = 1 : length(yfit)
    count = count + 1;
    totalCount = totalCount + 1;
    if(yfit(i) == 1)
        target = [target; yfit(i)];
    else
        nonTarget = [nonTarget; yfit(i)];
    end
    
    if(count == 64)
        count = 0;
        if(length(target) >= length(nonTarget))
            finalVector = [finalVector; ones(64,1)];
        else
            finalVector = [finalVector; -1*ones(64,1)];
        end
        target = [];
        nonTarget = [];
    end
end

if(length(finalVector) == length(classVar))
    k = finalVector==classVar(:,15);
    iwant = sum(k(:));
    percentage = iwant/(length(classVar)) * 100;
    disp(['Training Accuracy: ' num2str(percentage)]);
elseif(length(finalVector) == length(testData))
    k = finalVector==testData(:,15);
    iwant = sum(k(:));
    percentage = iwant/(length(testData)) * 100;
    disp(['Testing Accuracy: ' num2str(percentage)]);
end

%disp(['Target Accuracy: ' num2str(correctTargetCounter/(length(yfit)/384)*100) '%']);
%disp(['NonTarget Accuracy: ' num2str(correctNonTargetCounter/(length(yfit)/384)*100) '%']);