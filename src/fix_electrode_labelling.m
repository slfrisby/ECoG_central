function fix_electrode_labelling(path)

    % Some participants have electrode F14 mislabelled as F_14. Fix this!

    % Arguments:
    % - path: path to data file. The name of the data file should be in
    % BIDS format. Character vector

    % load data file
    dataFile = load(path);

    % use indexing to locate the main data structs within this file
    variableNames = fieldnames(dataFile);
    dataIndex = false(length(fieldnames(dataFile)),1);
    for i = 1:length(fieldnames(dataFile))
        if isstruct(dataFile.(variableNames{i}))
            dataIndex(i) = true;
        end
    end
    variableNames = variableNames(dataIndex);

    % for each data struct (some participants have more than one)
    for i = 1:length(variableNames)
        % get channel names as a cell array
        channelNames = cellstr(dataFile.(variableNames{i}).DIM(2).label);

        % if any of the channels are mislabelled as F_14
        if any(strcmp(channelNames,'F_14'))
            % find the index of the mislabelled channel
            channelIndex = find(strcmp(channelNames,'F_14'));
            % fix!
            channelNames(channelIndex) = {'F14'};
            % update the channel names in the data 
            dataFile.(variableNames{i}).DIM(2).label = char(channelNames);
        end
    end

    % save the data
    save(path,'-struct','dataFile','-v7.3')
    clear dataFile
end